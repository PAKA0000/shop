package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.UUID;

import dto.Emp;
import dto.Goods;
import dto.GoodsImg;


@WebServlet("/emp/addGoods")
public class AddGoodsController extends HttpServlet {

       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/emp/addGoods.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String goodsName = request.getParameter("goodsName");
		String goodsPrice = request.getParameter("goodsPrice");
		String pointRate = request.getParameter("pointRate");
		//  파일업로드는 part 라이브러리 사용
		Part part = request.getPart("goodsImg");
		String originName = part.getSubmittedFileName();
		String filename = UUID.randomUUID().toString().replace("-", "");
		filename += originName.substring(originName.lastIndexOf("."));
		String contentType = part.getContentType();
		long filesize = part.getSize();
		
		
		if(!(contentType.equals("image/png")||contentType.equals("image/jpeg")||contentType.equals("image/gif"))) {
			response.sendRedirect(request.getContextPath()+"/emp/addGoods");
			System.out.print("이미지 출력");
			return;
		}
		Emp loginEmp= (Emp)(request.getSession().getAttribute("logingEmp"));
		
		Goods goods = new Goods();
		goods.setGoodsName(goodsName);
		goods.setGoodsPrice(Integer.parseInt(goodsPrice));
		goods.setPointRate(Double.parseDouble(pointRate));
		goods.setEmpCode(loginEmp.getEmpCode());
		int goodsCode = 0;
		
		GoodsImg goodsImg = new GoodsImg();
		goodsImg.setGoodsCode(goodsCode);
		goodsImg.setOriginName(originName);
		goodsImg.setFilesize(filesize);
		
		String realPath = request.getServletContext().getRealPath("upload");
		File saveFile = new File(realPath,filename); //빈 파일
		InputStream is = part.getInputStream(); 
		OutputStream os = Files.newOutputStream(saveFile.toPath());
		
		is.transferTo(os);
		
	}
}











