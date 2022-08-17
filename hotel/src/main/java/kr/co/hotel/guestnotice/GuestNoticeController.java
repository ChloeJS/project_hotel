package kr.co.hotel.guestnotice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.hotel.guest.GuestVO;

@Controller
public class GuestNoticeController {

	@Autowired
	GuestNoticeService service;
	
	// 목록
	@GetMapping("/guestnotice/list.do")
	public String index(Model model, GuestNoticeVO vo) {
		model.addAttribute("data", service.index(vo));
		return "guestnotice/list";
	}
	
	// 조회
	@GetMapping("/guestnotice/view.do")
	public String view(Model model, GuestNoticeVO vo) {
		service.updateViewcount(vo.getGnotice_no());
		model.addAttribute("data", service.view(vo));
	
		return "guestnotice/view";
	}

	
} 
