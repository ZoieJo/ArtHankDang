package kr.or.arthakdang.facilityreserv.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.arthakdang.facilityreserv.domain.FacilityReservVO;
import kr.or.arthakdang.facilityreserv.domain.TimeVO;
import kr.or.arthakdang.mapper.FacilityReservMapper;

@Service
public class FacilityReservServiceImpl implements FacilityReservService{
	
	@Autowired
	FacilityReservMapper facilityReservMapper;
	
	@Override
	public List<FacilityReservVO> facilityReservList(String facirsvDt) {
		return facilityReservMapper.facilityReservList(facirsvDt);
	}

	@Override
	public int insertFacReserv(FacilityReservVO faciltyReservVO) {
		return facilityReservMapper.insertFacReserv(faciltyReservVO);
	}

	@Override
	public int updateFacReserv(FacilityReservVO faciltyReservVO) {
		return facilityReservMapper.updateFacReserv(faciltyReservVO);
	}

	@Override
	public int deleteFacReserv(FacilityReservVO facilityReservVO) {
		return facilityReservMapper.deleteFacReserv(facilityReservVO);
	}

	@Override
	public int onePickFacList(String memId) {
		return facilityReservMapper.onePickFacList(memId);
	}

	@Override
	public List<TimeVO> timeList(TimeVO timevo) {
		return facilityReservMapper.timeList(timevo);
	}

	@Override
	public List<FacilityReservVO> facilityReservList2(FacilityReservVO facilityReservVO) {
		return facilityReservMapper.facilityReservList2(facilityReservVO);
	}

	@Override
	public List<String> facTimeList(String facirsvDt) {
		// TODO Auto-generated method stub
		return null;
	}




	
	

}
