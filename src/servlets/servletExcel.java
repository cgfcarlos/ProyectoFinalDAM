package servlets;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import hibernate.Operacion;

/**
 * Servlet implementation class servletExcel
 */
@WebServlet("/servletExcel")
public class servletExcel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletExcel() {
        super();

    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession sesion = request.getSession();
			List<Operacion> operaciones = new ArrayList<Operacion>();
			operaciones = (ArrayList<Operacion>) sesion.getAttribute("operaciones");

			XSSFWorkbook workbook = new XSSFWorkbook();
			XSSFSheet sheet = workbook.createSheet("Extracto " + (1 + Calendar.getInstance().get(Calendar.MONTH)) + "-"
					+ Calendar.getInstance().get(Calendar.YEAR));


			XSSFCellStyle style = workbook.createCellStyle();
			// style.setBorderTop(BorderStyle.DOUBLE);
			style.setBorderBottom(BorderStyle.THIN);
			// style.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);

			XSSFFont font = workbook.createFont();
			font.setFontName(HSSFFont.FONT_ARIAL);
			font.setFontHeightInPoints((short) 20);
			font.setBold(true);
			font.setColor(HSSFColor.DARK_GREEN.index);
			style.setFont(font);

			int rowCount = 0;

			XSSFRow fila = sheet.createRow(++rowCount);
			XSSFCell celda = fila.createCell(1);
			celda.setCellStyle(style);
			celda.setCellValue("CONTABILIDADCGF Extracto - " + Calendar.getInstance().get(Calendar.MONTH) + "/"
					+ Calendar.getInstance().get(Calendar.YEAR));
			for (Operacion op : operaciones) {
				if (op.getFechaOperacion().getMonth() == Calendar.getInstance().get(Calendar.MONTH)) {

					int columnCount = 0;
					// Fila
					XSSFRow row = sheet.createRow(++rowCount);
					// Celdas
					XSSFCell cell = row.createCell(++columnCount);
					cell.setCellValue(op.getNombreOperacion());

					XSSFCell cell2 = row.createCell(++columnCount);
					cell2.setCellValue(op.getTipoOperacion());

					XSSFCell cell3 = row.createCell(++columnCount);
					cell3.setCellValue(op.getCuantia().doubleValue());

					XSSFCell cell4 = row.createCell(++columnCount);
					cell4.setCellValue(op.getFechaOperacion());

					XSSFCell cell5 = row.createCell(++columnCount);
					cell5.setCellValue(op.getFechaValor());
				}
			}
			String NOMBRE_DOCUMENTO = "Extracto_" + Calendar.getInstance().getTimeInMillis() + ".xlsx";
			try (FileOutputStream outputStream = new FileOutputStream(
					"C:\\Users\\carlo\\workspace\\ProyectoFinal\\WebContent\\usuarios\\"
							+ sesion.getAttribute("user").toString() + "\\" + NOMBRE_DOCUMENTO)) {
				workbook.write(outputStream);
				request.getRequestDispatcher("main.jsp").forward(request, response);
			}
		} catch (Exception ex) {
			System.out.println(ex.toString());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}

