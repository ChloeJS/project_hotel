package kr.co.hotel.room;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.hotel.review.ReviewVO;

@Service
public class RoomServiceImpl implements RoomService {
	
	@Autowired
	RoomMapper mapper;

	@Override
	public RoomVO roomView(int room_no) {
		return mapper.roomView(room_no);
	}

	@Override
	public List<RoomVO> getRoomImage(int room_no) {
		return mapper.getRoomImage(room_no);
	}

	@Override
	public List<ReviewVO> getReviewList(int room_no) {
		return mapper.getReviewList(room_no);
	}

}
