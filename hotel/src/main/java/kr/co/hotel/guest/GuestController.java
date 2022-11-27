package kr.co.hotel.guest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hotel.admin.AdminVO;


@Controller
public class GuestController {
	@Autowired
	GuestService gservice;
	
	@GetMapping("/guest/join.do")
	public String join() {
		return "guest/join";
	}
	
	@PostMapping("/guest/join.do")
	public String join(GuestVO gvo, Model model) {
		if (gservice.insert(gvo) > 0) {
			model.addAttribute("msg", "정상적으로 회원가입되었습니다.");
			model.addAttribute("url", "login.do");
			return "common/alert";
		} else {
			model.addAttribute("msg", "회원가입오류");
			return "common/alert";
		}
	}
	@GetMapping("/guest/login.do")
	public String login(HttpSession sess, Model model) {
		if(sess.getAttribute("loginInfo")!=null) {
			model.addAttribute("msg", "중복로그인입니다. 로그아웃해주세요");
			return "common/alert";
		}
		return "guest/login";
	}
	
	@PostMapping("/guest/login.do")
	public String login(GuestVO gvo, HttpSession sess, Model model) {
		if (gservice.guestloginCheck(gvo, sess)) {
			return "redirect:/main/main.do";
		} else {
			model.addAttribute("msg", "로그인정보를 확인해 주세요");
			return "common/alert";
		}
	}
	
	
	@GetMapping("/guest/emailDupCheck.do")
	public void emailDupCheck(@RequestParam String guest_email, HttpServletResponse res) throws IOException {
		int count = gservice.emailDupCheck(guest_email);
		boolean r = false;
		if (count >= 1) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	@GetMapping("/guest/idDupCheck.do")
	public void idDupCheck(@RequestParam String guest_id, HttpServletResponse res) throws IOException {
		int count = gservice.idDupCheck(guest_id);
		boolean r = false;
		if (count >= 1) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	@GetMapping("/guest/hpDupCheck.do")
	public void hpDupCheck(@RequestParam String guest_hp, HttpServletResponse res) throws IOException {
		int count = gservice.hpDupCheck(guest_hp);
		boolean r= false;
		if (count >= 1) r = true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
	}
	
	@GetMapping("/guest/logout.do")
	public String logout(Model model, HttpServletRequest req) {
		HttpSession sess = req.getSession();
		sess.invalidate(); // 세션초기화(세션객체에있는 모든 값들이 삭제)
		//sess.removeAttribute("loginInfo"); // 세션객체의 해당값만 삭제
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "/hotel/guest/login.do");
		return "common/alert";
	}
	
	@GetMapping("/guest/findGuestId.do")
	public String findGuestId() {
		return "guest/findId";
	}
	
	@PostMapping("/guest/findGuestId.do")
	public String findGuestEmail(Model model, GuestVO param) {
		GuestVO gvo = gservice.findGuestId(param);
		if (gvo != null) {
			model.addAttribute("result", gvo.getGuest_id());
		}
		return "common/return";
	}
	
	@GetMapping("/guest/findGuestPwd.do")
	public String findGuestPwd() {
		return "guest/findPwd";
	}
	
	@PostMapping("/guest/findGuestPwd.do")
	public String findGuestPwd(Model model, GuestVO param) {
		GuestVO gvo = gservice.findGuestPwd(param);
		if (gvo != null) {
			model.addAttribute("result", gvo.getGuest_pwd());
		}
		return "common/return";
	}
	@GetMapping("/guest/mypage.do")
	public String mypage(HttpSession sess, Model model) {
		if(sess.getAttribute("loginInfo")==null) {
			//loginInfo는 게스트 전용 호스트는 lgoinInfo2
			//게스트가 로그아웃하면 null 로그인하면 not null
			//로그인해야 myPage.jsp로 넘어갈수 있음 
			model.addAttribute("msg","로그인 해야합니다");
			return "common/alert";
		}else {
			return "/guest/myPage";//myPage는 포인트, 예약내역등을 볼수 있는 곳, 이페이지에서 '내정보관리'로 넘어갈수 있음
		}
	}
	
	@GetMapping("/guest/myinfo.do")
	public String myinfo(HttpSession sess, Model model) {
		if(sess.getAttribute("loginInfo") == null) {
			model.addAttribute("msg","로그인이 필요한 기능입니다");
			return "common/alert";
		}else { 
			return"/guest/myinfoLogin";
			//로그인이 되어 있어야 myinfoLogin.jsp로 넘어갈수 있음
		}
	}
	
	@PostMapping("/guest/myinfoLogin.do")
	public void myinfoLogin(GuestVO gvo, HttpServletResponse res, HttpSession sess) throws IOException {
		GuestVO myinfo=(GuestVO)sess.getAttribute("loginInfo");
		myinfo.setGuest_pwd(gvo.getGuest_pwd());
		boolean r=false;
		if(gservice.myinfoLogin(myinfo)!=null) r=true;
		PrintWriter out = res.getWriter();
		out.print(r);
		out.flush();
		//한번더 패스워드를 체크하는 행위 그래야 '내정보수정이 가능'하게끔 다음 페이지(myinfoModify.jsp)로 넘어감
	}
	@PostMapping("/guest/myinfoModify.do")//비밀번호등 민감한 정보가 있어서 Post방식
	public String myinfoModify() {
		return "/guest/myinfoModify";//내정보 수정하는 jsp
	}
	@GetMapping("/guest/pwdChangePopup.do")
	public String pwdChangePopup() {
		return "/guest/pwdChangePopup";
	}
	 
	@PostMapping("/guest/updatePwd.do") 
	public void updatePwd(HttpSession sess, GuestVO gvo, HttpServletResponse res) throws IOException { 
		GuestVO myinfo=(GuestVO)sess.getAttribute("loginInfo");
		myinfo.setGuest_pwd(gvo.getGuest_pwd());
		boolean r=false;
		if (gservice.updatePwd(myinfo) > 0) {
			r=true;
			PrintWriter out = res.getWriter();
			out.print(r);
			out.flush();
		}
	}
	 @PostMapping("/guest/update.do")
	 public String update(GuestVO gvo, Model model) {
		 if(gservice.totalUpdate(gvo)) {
			 model.addAttribute("msg", "자동 로그아웃됩니다.다시 로그인해주세요");
			 model.addAttribute("url", "/hotel/guest/logout.do");
			 return "common/alert";
		 }else {
			 model.addAttribute("msg","수정실패");
			 return "common/alert";
		 }
	 }
	 @GetMapping("/guest/deleteGuestInfo.do")
	 public String deleteGuest(HttpSession sess, Model model) {
		 if(sess.getAttribute("loginInfo") == null) {
				model.addAttribute("msg","로그인이 필요한 기능입니다");
				return "common/alert";
			}else { 
				return"/guest/deleteGuest";
				//로그인이 되어 있어야 deleteGuest.jsp로 넘어갈수 있음
			}
	 }
	 @PostMapping("/guest/deleteGuestInfo.do")
	 public void deleteGuestInfo(HttpSession sess , GuestVO gvo, HttpServletResponse res) throws IOException {
		 GuestVO myinfo =(GuestVO)sess.getAttribute("loginInfo");
		 myinfo.setGuest_pwd(gvo.getGuest_pwd());
		 boolean r=false;
		 if(gservice.deleteGuestInfo(myinfo) != null) 
			 r=true;
			 PrintWriter out = res.getWriter();
			 out.print(r);
			 out.flush();
		 		 
	 }

	 
	 @GetMapping("/admin/main/guest/guestlist.do")
	 public String guestlist(AdminVO avo, Model model) {
			model.addAttribute("guestlist", gservice.guestListPaging(avo));
			return "/admin/main/guest/guestlist";
		}
	 
	 @GetMapping("/amdin/main/gusetview.do")
	 public String guestview(GuestVO vo, Model model) {
			model.addAttribute("guestlist",gservice.guestlist(vo));
			return "/admin/main/guest/guestview";
		}

	 @PostMapping("/guest/realNameApi.do")
	 @ResponseBody
	 public ApiVO realNameApi(ApiVO avo,HttpSession sess, HttpServletResponse res, Model model) throws Exception {
		 openBankingAPI api=new openBankingAPI();
		 boolean r= false;
		 String code = api.bankingRealNameApi(avo,sess);
		 System.out.println("code="+code);
		 model.addAttribute("acc",avo.getAccount_holder_name());
		 System.out.println("내가 확인하려는 인증계좌실명"+avo.getAccount_holder_name());
		 if(code.equals("A0000")) {
			 avo.setResult(true);
			 return avo;
		 }else {
			 avo.setResult(false);
			 return avo;
		 }
		
	 }
}
