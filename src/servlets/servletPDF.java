package servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class servletPDF
 */
@WebServlet("/servletPDF")
public class servletPDF extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public servletPDF() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String extracto = request.getParameter("extracto");
			if (extracto != null && extracto != "") {
				HttpSession sesion = request.getSession();
				String fileName = "C:\\Users\\carlo\\workspace\\ProyectoFinal\\WebContent\\usuarios\\"
						+ sesion.getAttribute("user").toString() + "\\" + request.getParameter("extracto").toString();
				String fileType = "";
				if (extracto.contains(".pdf")) {
					fileType = "application/pdf";
				} else if (extracto.contains(".xlsx")) {
					fileType = "application/vnd.ms-excel.sheet.macroenabled.12";
				}

				response.setContentType(fileType);

				response.setHeader("Content-disposition", "attachment; filename=" + fileName);

				File my_file = new File(fileName);

				OutputStream out = response.getOutputStream();
				FileInputStream in = new FileInputStream(my_file);
				byte[] buffer = new byte[4096];
				int length;
				while ((length = in.read(buffer)) > 0) {
					out.write(buffer, 0, length);
				}
				in.close();
				out.flush();

			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
