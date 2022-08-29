package kr.co.hotel.hostboard;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.hotel.host.HostVO;
import util.ImgHandling;

@Controller
public class Admin_HostBoardController extends ImgHandling {

	@Autowired
	HostBoardService service;

	// 목록
	@GetMapping("/admin/main/hostboard/qna/list.do")
	public String index(Model model, HostBoardVO vo) {
		model.addAttribute("data", service.index(vo));
		return "admin/main/hostboard/qna/list";
	}

	// 조회
	@GetMapping("/admin/main/hostboard/qna/view.do")
	public String view(Model model, HostBoardVO vo) {
		// System.out.println(vo.get);
		service.viewCount(vo.getHboard_no());
		HostBoardVO hvo = service.view(vo.getHboard_no());
		model.addAttribute("data", hvo);

		return "admin/main/hostboard/qna/view";
	}


	// 답변달기 폼
	@GetMapping("/admin/main/hostboard/qna/answer.do")
	public String editForm(Model model, HostBoardVO vo) {
		model.addAttribute("data", service.edit(vo.getHboard_no()));
		System.out.println("======================================" + model.getAttribute("data"));
		return "admin/main/hostboard/qna/answer";
	}

	// 답변달기 처리
	@PostMapping("/admin/main/hostboard/qna/answer.do")
	public String update(HostBoardVO vo, Model model) {

		if (service.replyupdate(vo)) {
			model.addAttribute("data", service.replyupdate(vo));
			model.addAttribute("msg", "정상적으로 답변이 등록되었습니다.");
			model.addAttribute("url", "list.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "등록 실패했습니다.");
			return "common/alert";
		}
	}

	
	// 
	
	// 삭제처리
	@GetMapping("/admin/main/hostboard/qna/delete.do")
	public String delete(HostBoardVO vo, Model model) {
		if (service.delete(vo.getHboard_no())) {

			model.addAttribute("msg", "정상적으로 삭제되었습니다.");
			model.addAttribute("url", "list.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "삭제 실패했습니다.");
			return "common/alert";
		}

	}

}
