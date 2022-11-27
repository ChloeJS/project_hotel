package kr.co.hotel.reserve;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hotel.guest.GuestVO;
import kr.co.hotel.main.HotelVO;

@Controller

public class ReserveController {
	
	@Autowired
	ReserveService service;
	
	//예약하기
	@PostMapping("/reserve/reserve.do")
	public String reserve(ReserveVO vo, HotelVO hvo, Model model) {
		model.addAttribute("hotelinfo",service.SelectHotelInfo(hvo) );
		model.addAttribute("roominfo", service.SelectRoomInfo(vo));
		model.addAttribute("totalpoint", service.SelectTotalPoint(vo));
		model.addAttribute("totalprice", service.SelectRoomPrice(vo));
		
		return "/reserve/reserve";
	}
	
	//보유 쿠폰 리스트
	@GetMapping("/reserve/couponlist.do")
	public String couponlist(GuestVO vo, Model model) {
		System.out.println("============id==="+ vo.getGuest_id());
		model.addAttribute("data", service.couponlist(vo));
		return "/reserve/couponlist";
	}
	
	//예약하기
	@PostMapping("/reserve/reserveinsert.do")
	@ResponseBody
	public int reserveinsert(ReserveVO vo,GuestVO gvo, Model model) {
		return service.insert(vo, gvo); //0,1조회값
	}
	
	//예약 중복체크
	@PostMapping("/reserve/reservecheck.do")
	@ResponseBody
	public int reservecheck(ReserveVO vo) {
		return service.reservecheck(vo);
	}
	
	
	//쿠폰 삭제 및 미입금 사용자 취소 스케줄러(만료시)
	//@Scheduled(cron = "0/10 * * * * *")
	public void Coupon_PayDelete() {
		service.CouponDelete();
		List<ReserveVO> list = service.CancleList();
		for(int i=0; i<list.size();i++) {
			ReserveVO vo = list.get(i);
			list.get(i).getReserv_no();
			service.UpdateReserveStatus(vo);
			if(vo.getUsed_point() !=0) {
				service.UpdateGuestPoint(vo);
				service.InsertPointTable(vo);
			}
			if(vo.getCoupon_no() !="") {
				service.UpdateCouponStatus(vo);
			}	
		}
	
    }
	
	//무통장입금 확인페이지
	@GetMapping("/reserve/paytransfer.do")
	public void paytransfer(ReserveVO vo, HotelVO hvo, Model model) {
		model.addAttribute("reserveinfo", service.SelectReserveInfo(vo));
		model.addAttribute("hostinfo", service.SelectHostNo(hvo));
	}
	
	
	//무통장입금 처리페이지
	@PostMapping("/reserve/paytransfer.do")
	@ResponseBody
	public Map paytransferpro(ReserveVO vo, HotelVO hvo, GuestVO gvo, Model model) {
		Map map = new HashMap();
		map.put("check",service.insert(vo, gvo));
		map.put("imp_uid", vo.getImp_uid());
		return map;
	}
	
	//결제확인
	@PostMapping("/reserve/paycheck.do")
	public String paycheck(ReserveVO vo, Model model) {
		service.UpdatePay_Status(vo);
		return "/hostReserve/index";
	}
	
	
	
	//-----이하 빛찬-----------------------------------------------
	//-----게스트-----------------------------------------------
	@GetMapping("/reserve/index.do")
	public String index(Model model,HotelVO hvo, ReserveVO vo, HttpSession sess, HttpServletRequest req) {
		GuestVO Host_loginInfo = (GuestVO) sess.getAttribute("loginInfo");
		vo.setGuest_no(Host_loginInfo.getGuest_no());
		model.addAttribute("data", service.index(vo));
		model.addAttribute("totalpoint", service.SelectTotalPoint(vo));
		return "reserve/index";
	}
	

}
