package com.dm.sche.controller.rest;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dm.sche.dto.PagingDTO;
import com.dm.sche.model.Board;
import com.dm.sche.service.BoardService;

@RestController
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	/**
	 * 
	 * @return
	 *
	 * @Author	: Ko MiJung
	 * @Date	: 2019. 8. 9.
	 * @Comment : 공통 게시판 리스트
	 *
	 */
	@PostMapping("/list")
	public Map<String, Object> selectBoardList (PagingDTO<Board> pagingDTO){
		return boardService.select(pagingDTO);
	}
	
	private final static String filePath = "/Users/idaesan/Documents/file/";
	
	@PostMapping("/fileUpload")
	public void file_uploader_html5(
			@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request, HttpServletResponse response){
		System.out.println(multipartFile);
		
		InputStream is = null;
		OutputStream os = null;
		
		// 파일명
//		String fileName = request.getHeader("file-name");
//		// 파일 확장자
//		String fileNameExt = fileName.substring(fileName.lastIndexOf(".") + 1);
//		fileNameExt = fileNameExt.toLowerCase();
		
		
		try { 
			
			// 파일정보 
			String sFileInfo = ""; 
			
			// 파일명을 받는다 - 일반 원본파일명 
			String filename = request.getHeader("file-name"); 
			
			// 파일 확장자 
			String filename_ext = filename.substring(filename.lastIndexOf(".")+1); 
			filename = filename.substring(0, filename.lastIndexOf("."));
			
			// 확장자를소문자로 변경
			filename_ext = filename_ext.toLowerCase(); 
			
			// 이미지 검증 배열변수 
			String[] allow_file = {"jpg","png","bmp","gif"}; 
			
			// 돌리면서 확장자가 이미지인지
			int cnt = 0; 
			for( int i = 0; i < allow_file.length; i++ ) {
				
				if ( filename_ext.equals(allow_file[i]) ) { 
					cnt++; 
				} 
			} 
			
			// 이미지가 아님 
			if ( cnt == 0 ) {
				
				PrintWriter print = response.getWriter(); 
				
				print.print("NOTALLOW_"+filename); 
				print.flush(); 
				print.close(); 
				
			} else { 
				
				// 이미지이므로 신규 파일로 디렉토리 설정 및 업로드	
				// 파일 기본경로
				String dftFilePath = request.getSession().getServletContext().getRealPath("/"); 
				
				// 파일 기본경로 _ 상세경로
				//String filePath = dftFilePath + "resources" + File.separator + "editor" + File.separator +"multiupload" + File.separator; 
				String filePath = "/Users/idaesan/Documents/file/";
				File file = new File(filePath); 
				if( !file.exists() ) { 
					file.mkdirs(); 
				} 
				
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss"); 
				String today = formatter.format(new Date()); 
				
				//realFileNm = today+UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf(".")); 
				filename += "_" + today + "." + filename_ext;
				
				String rlFileNm = filePath + filename;
				
				///////////////// 서버에 파일쓰기 ///////////////// 
				is = request.getInputStream();
				os = new FileOutputStream(rlFileNm); 
				
				int numRead; 
				
				byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))]; 
				
				System.out.println("================================");
				System.out.println(b.length);
				System.out.println(request.getInputStream());
				System.out.println(is.read(b));
				while( (numRead = is.read(b,0,b.length) ) != -1 ) { 
//					os.write(b,0,numRead); 
				} 
				System.out.println("================================");
				
				if ( is != null ) {
					is.close(); 
				} 
				
				//os.flush();
				os.close(); 
				
				///////////////// 서버에 파일쓰기 ///////////////// 
				
//				// 정보 출력 
//				sFileInfo += "&bNewLine=true"; 
//				// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
//				sFileInfo += "&sFileName="+ filename;
//				sFileInfo += "&sFileURL="+"/resources/editor/multiupload/"+realFileNm; 
//				
//				PrintWriter print = response.getWriter(); 
//				System.out.println("--------------" + print);
//				print.print(sFileInfo);
//				print.flush(); 
//				print.close(); 
			}	
			
		} catch (Exception e) { 
			e.printStackTrace(); 
			
		}

	}
	
}
