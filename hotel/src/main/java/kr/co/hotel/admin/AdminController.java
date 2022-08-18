package kr.co.hotel.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AdminController {
	@Autowired
	AdminService aservice;
	
	@GetMapping("/admin/login.do")
	 public String adminLogin() {
		return "admin/main/login";
	}
	@PostMapping("/admin/login.do")
	public String adminLogin(AdminVO avo,HttpSession sess, Model model) {
		if(aservice.adminLogin(avo, sess)) {
			return "/admin/main/adminMain";
		}else {
			model.addAttribute("msg", "로그인정보를 다시 확인해주세요");
			return "common/alert";
		}
	}
	@GetMapping("/admin/logout.do")
	public String logout(Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		sess.invalidate(); // 세션초기화(세션객체에있는 모든 값들이 삭제)
		//sess.removeAttribute("loginInfo"); // 세션객체의 해당값만 삭제
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "/hotel/admin/login.do");
		return "common/alert";
	}

}