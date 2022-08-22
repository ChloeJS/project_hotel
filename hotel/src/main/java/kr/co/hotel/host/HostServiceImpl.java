package kr.co.hotel.host;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hotel.admin.AdminVO;
import util.SendMail;
@Service
public class HostServiceImpl implements HostService {

	@Autowired
	HostMapper hmapper;

	@Override
	public int insert(HostVO hvo) {
		return hmapper.insert(hvo);
	}

	@Override
	public int emailDupCheck(String host_email) {
		return hmapper.emailDupCheck(host_email);
	}

	@Override
	public int idDupCheck(String host_id) {
		return hmapper.idDupCheck(host_id);
	}
	@Override
	public int hpDupCheck(String host_hp) {
		return hmapper.hpDupCheck(host_hp);
	}
	@Override
	public boolean HostloginCheck(HostVO hvo, HttpSession sess) {
		boolean r = false;
		HostVO loginInfo = hmapper.hostloginCheck(hvo);
		if (loginInfo != null) {
			r = true;
			// 로그인 성공시 세션에 저장
			sess.setAttribute("loginInfo2", loginInfo);
		}
		return r;
	}

	@Override
	public HostVO findHostId(HostVO hvo) {
		return hmapper.findHostId(hvo);
	}
	@Override
	public HostVO findHostPwd(HostVO hvo) {
		// update
		HostVO mv = hmapper.findHostPwd(hvo);
		if (mv != null) {
			// 임시비밀번호 생성
			// 영문두자리, 숫자두자리
			String temp = "";
			for (int i=0; i<2; i++) {
				temp += (char)(Math.random()*26+65);
			}
			for (int i=0; i<3; i++) {
				temp += (int)(Math.random()*9);
			}
			
			// 임시비밀번호 update
			hvo.setHost_pwd(temp);
			hmapper.updateTempHostPwd(hvo);
			
			// email발송
			SendMail.sendMail("gdbebe@naver.com", hvo.getHost_email(), "[둘이놀까]임시비밀번호", "임시비밀번호:"+temp);
			
			return mv;
		} else {
			return null;
		}
	}
	@Override
	public HostVO myinfoLogin(HostVO hvo) {
		return hmapper.myinfoLogin(hvo);
	}

	@Override
	public int updatePwd(HostVO hvo) {
		return hmapper.updatePwd(hvo);
	}

	@Override
	public boolean totalUpdate(HostVO hvo) {
		return hmapper.totalUpdate(hvo) >0? true:false;
	}
	@Override
	public HostVO deleteHostInfo(HostVO hvo) {
		// update
				HostVO mv = hmapper.deleteHostInfo(hvo);
				if (mv != null) {
					// 임시비밀번호 생성
					// 영문두자리, 숫자두자리
					String temp = "";
					for (int i=0; i<2; i++) {
						temp += (char)(Math.random()*26+65);
					}
					for (int i=0; i<3; i++) {
						temp += (int)(Math.random()*9);
					}
					
					// 임시비밀번호 update
					hvo.setHost_pwd(temp);
					hmapper.fakeDelete(hvo);
					
					return mv;
				} else {
					return null;
				}
			}

	//=====================이하 이원표 작성=================
	@Override
	public Map getHostList(AdminVO vo) {
		
		int totalCount = hmapper.getHostCount(vo); //총 게시물수
		int totalPage = totalCount / vo.getPageRow(); //총 페이지수
		
		if (totalCount % vo.getPageRow() > 0 ) totalPage++;
		
		/*
		 * 총 게시물 수 12개 총 페이지는 12 / 한 페이지에 표시되는 행(게시물개수) 수 10개 1페이지(10행), 2행 12 % 10 > 0
		 */
		
		// 페이지별 시작 인덱스 mySQL 에서는 시작이 0부터니까 
		int startIdx = (vo.getPage() - 1 ) * vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<HostVO> list = hmapper.getHostList(vo);
		
		// 페이징처리
		int endPage = (int)(Math.ceil(vo.getPage()/10.0) * 10);
		int startPage = endPage - 9;
		
		if (endPage > totalPage) endPage = totalPage;
		
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;
		
		Map map = new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("startIdx", startIdx);
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("prev", prev);
		map.put("next", next);
		map.put("list", list);
		return map;
	}

	@Override
	public int getHostCount(AdminVO vo) {
		return hmapper.getHostCount(vo);
	}
	@Override
	public HostVO getView(HostVO vo) {
		return hmapper.getView(vo);
	}
}