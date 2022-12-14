package kr.co.hotel.guestfaq;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class GuestFaqController {

	@Autowired
	GuestFaqService service;

	// 조회
	@GetMapping("/guestfaq/view.do")
	public String view(Model model, GuestFaqVO vo) {
		GuestFaqVO r = service.view(vo.getGfaq_no());
		System.out.println("==================================" + r);
		model.addAttribute("data", service.list(vo));
		return "guestfaq/view";
	}


}
