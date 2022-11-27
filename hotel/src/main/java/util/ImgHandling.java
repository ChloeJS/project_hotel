package util;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import kr.co.hotel.HRRegister.HRRegisterMapper;
import kr.co.hotel.room.RoomVO;

public class ImgHandling {
		
	@Autowired
	HRRegisterMapper mapper;
	
	public static Map imghandle( MultipartFile filename, HttpServletRequest req) {
	
		//파일명 구하기
		String org= filename.getOriginalFilename();//사용자가 첨부한 원본 파일명을 가져옴
		String ext = org.substring(org.lastIndexOf("."));//확장자
		String real = new Date().getTime()+ext;//변경된 filename "1314131"+".확장자명"

		//파일저장
		String path	= req.getRealPath("/upload/");//경로불러오기
		try {
			
			filename.transferTo(new File(path+real));
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("ImgHandle 업로드 중 예외 발생");
		}
		
		Map map = new HashMap();
		
		map.put("filename_org", org);
		map.put("filename_real", real);
		
		return map;
	}

}
