package servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.CMYKColor;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import hibernate.CuentaBancaria;
import hibernate.Operacion;

/**
 * Servlet implementation class servletGenerarExtracto
 */
@WebServlet("/servletGenerarExtracto")
public class servletGenerarExtracto extends HttpServlet {
	private static final long serialVersionUID = 1L;

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletGenerarExtracto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

			// response.getWriter().append("Served at: ").append(request.getContextPath());
			Date currentDate = new Date();
			HttpSession sesion = request.getSession();
			CuentaBancaria cuenta = (CuentaBancaria) sesion.getAttribute("cuenta");
			BigDecimal sum = BigDecimal.ZERO;

			// String path = request.getRequestURL().toString();
			String context = request.getContextPath();
			System.out.println(context);

			String ruta = context + "/WebContent/usuarios/" + sesion.getAttribute("user").toString() + "/";
			System.out.println(ruta);
			String NOMBRE_DOCUMENTO = "Extracto_" + currentDate.getTime() + ".pdf";
			// Creamos el documento.
			Document documento = new Document();
			// Creamos el fichero con el nombre
			File f = new File("C:\\Users\\carlo\\workspace\\ProyectoFinal\\WebContent\\usuarios\\"
					+ sesion.getAttribute("user").toString() + "\\" + NOMBRE_DOCUMENTO);
			// f.createNewFile();
			f.setReadable(true);
			f.setWritable(true);
			// Creamos el flujo de datos de salida para el fichero donde guardaremos el pdf.
			FileOutputStream ficheroPdf = new FileOutputStream(f.getPath());

			// Asociamos el flujo que acabamos de crear al documento.

			PdfWriter.getInstance(documento, ficheroPdf);

			// Abrimos el documento.
			documento.open();

			Font font = FontFactory.getFont(FontFactory.HELVETICA, 20, Font.BOLD, CMYKColor.BLACK);

			Image image = Image.getInstance("logo.png");
			// image.scaleAbsolute(100, 50);
			image.setAbsolutePosition(350f, 800f);
			documento.add(image);

			documento.add(new Paragraph("Extracto " + currentDate.getDate() + "/" + (currentDate.getMonth() + 1) + "/"
					+ currentDate.getYear(), font));

			documento.add(new Paragraph(" "));

			List<Operacion> operaciones = (ArrayList<Operacion>) sesion.getAttribute("operaciones");

			// Insertamos una tabla.
			PdfPTable tabla = new PdfPTable(5);
			tabla.setWidthPercentage(100); // Width 100%
			tabla.setSpacingBefore(10f); // Space before table
			tabla.setSpacingAfter(10f); // Space after table
			// Set Column widths
			float[] columnWidths = { 1f, 1f, 1f, 1f, 1f };
			tabla.setWidths(columnWidths);

			Font fuente = FontFactory.getFont(FontFactory.HELVETICA, 20, Font.BOLD, CMYKColor.BLACK);

			Phrase p = new Phrase("Nombre Operación");
			p.setFont(fuente);

			PdfPCell cell = new PdfPCell(p);
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setVerticalAlignment(Element.ALIGN_MIDDLE);

			tabla.addCell(cell);

			Phrase p2 = new Phrase("Tipo Operación");
			p2.setFont(fuente);

			PdfPCell cell2 = new PdfPCell(p2);
			cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell2.setVerticalAlignment(Element.ALIGN_MIDDLE);

			tabla.addCell(cell2);

			Phrase p3 = new Phrase("Cuantía");
			p3.setFont(fuente);

			PdfPCell cell3 = new PdfPCell(p3);
			cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell3.setVerticalAlignment(Element.ALIGN_MIDDLE);

			tabla.addCell(cell3);

			Phrase p4 = new Phrase("Fecha Operación");
			p4.setFont(fuente);

			PdfPCell cell4 = new PdfPCell(p4);
			cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell4.setVerticalAlignment(Element.ALIGN_MIDDLE);

			tabla.addCell(cell4);

			Phrase p5 = new Phrase("Fecha Valor");
			p5.setFont(fuente);

			PdfPCell cell5 = new PdfPCell(p5);
			cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell5.setVerticalAlignment(Element.ALIGN_MIDDLE);

			tabla.addCell(cell5);

			for (Operacion o : operaciones) {
				tabla.addCell(o.getNombreOperacion());
				tabla.addCell(o.getTipoOperacion());
				tabla.addCell(String.valueOf(o.getCuantia().intValue()));
				tabla.addCell(o.getFechaOperacion().toString());
				tabla.addCell(o.getFechaValor().toString());
				sum = sum.add(o.getCuantia());
			}

			BigDecimal resultado = cuenta.getSaldo().subtract(sum);

			Class.forName("com.mysql.jdbc.Driver");

			Connection con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/contabilidad?autoReconnect=true&useSSL=false", "admin", "admin");

			Statement st = con.createStatement();

			String query = "UPDATE cuentabancaria SET saldo = " + resultado.doubleValue()
					+ " WHERE cuentabancariaid LIKE " + cuenta.getCuentaBancariaId();

			int row = st.executeUpdate(query);

			if (row == 1) {
				documento.add(tabla);
				documento.addTitle("Extracto");
				documento.addSubject(
						Calendar.getInstance().get(Calendar.MONTH) + "-" + Calendar.getInstance().get(Calendar.YEAR));
				documento.addKeywords("Java, PDF, iText");
				documento.addAuthor("Carlos González Fuentes");
				documento.addCreator("CONTABILIDADCGF");

				documento.close();

				request.getRequestDispatcher("main.jsp").forward(request, response);
			}

		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	/*
	 * protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
	 * IOException {
	 * 
	 * doGet(request, response); }
	 */


}
