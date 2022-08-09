package kr.co.hotel.HRRegister;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class HRRegisterServiceImpl implements HRRegisterService {

	@Autowired
	HRRegisterMapper mapper;
	
	@Override
	public Map index(RoomVO vo) {
		
		int totalCount = mapper.count(vo);//총개시물 수
		//총 페이지 수
		int totalPage = totalCount / vo.getPageRow();
		if(totalCount % vo.getPageRow() > 0) totalPage++;
		
		//시작 인덱스
		int startIdx = (vo.getPage()-1)*vo.getPageRow();
		vo.setStartIdx(startIdx);
		List<RoomVO> list = mapper.list(vo);
		
		//페이징 처리
		int endPage = (int)(Math.ceil(vo.getPage()/10.0)*10);
		int startPage = endPage - 9;
		if(endPage > totalPage) endPage= totalPage;
		boolean prev = startPage > 1 ? true : false;
		boolean next = endPage < totalPage ? true : false;
		
		Map map= new HashMap();
		map.put("totalCount", totalCount);
		map.put("totalPage", totalPage);
		map.put("list", list);
		map.put("page", vo.getPage());
		map.put("endPage", endPage);
		map.put("startPage", startPage);
		map.put("prev", prev);
		map.put("next", next);
		return map;
	}

	@Override
	public RoomVO view(int no) {
		
		
		return mapper.view(no);
	}

	@Override
	public RoomVO edit(int no) {
		return mapper.view(no);
 
		
	}

	@Override
	public boolean update(RoomVO vo) {
		return mapper.update(vo) >0?true:false;
	}

	@Override
	public boolean delete(int no) {
		//회원 삭제시, 회원테이블만 인스턴스만 지우는 것이 아니라 relation이 걸려있는 테이블을 모두 찾아서 delete해야한다.
		return mapper.delete(no)>0?true:false;
	}

	@Override
	public boolean insert(RoomVO vo) {
		
		return mapper.insert(vo) > 0 ? true : false;
	}

	@Override
	public boolean img_insert(RoomVO vo) {
		return mapper.img_insert(vo) > 0 ? true : false;
	}

	@Override
	public RoomVO get_hotelInfo(int host_no) {
		return mapper.get_hotelInfo(host_no);
	}

}