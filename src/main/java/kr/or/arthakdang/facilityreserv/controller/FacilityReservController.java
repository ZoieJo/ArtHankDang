package kr.or.arthakdang.facilityreserv.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.arthakdang.facilityreserv.domain.FacilityReservVO;
import kr.or.arthakdang.facilityreserv.domain.TimeVO;
import kr.or.arthakdang.facilityreserv.service.FacilityReservService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/fac")
@PreAuthorize("isAuthenticated()")
public class FacilityReservController {
	
	@Autowired
	FacilityReservService facilityReservService;
	
	@GetMapping("/main")
	public String getMain(String fbi, Model model, FacilityReservVO facilityReservVO) {

		Date toDay;
		if (fbi != null) {
			String[] hiyaho2 = fbi.split("-");

			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(hiyaho2[0]), Integer.parseInt(hiyaho2[1]) - 1, Integer.parseInt(hiyaho2[2]));
			toDay = new Date(cal.getTimeInMillis());
		} else {
			toDay = new Date();
		}

		facilityReservVO.setFacirsvDt(toDay);

		// 날짜 형식 포멧 지정
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");

		// 지정된 형식으로 날짜 변환
		String sDate = simpleDate.format(toDay);

		// 리스트 뿌려질때? 근데 지금은 안씀
		List<FacilityReservVO> faciltyReservList = facilityReservService.facilityReservList(sDate);

		// 시간 불러와짐
		List<TimeVO> time = facilityReservService.timeList(new TimeVO());

		// 테이블 막 for문을 날려 테이블 뿌려지게~
		ArrayList<ArrayList<Object>> table = new ArrayList<ArrayList<Object>>();

		for (int i = 0; i < 6; i++) {
			table.add(new ArrayList<Object>(10));
			table.get(i).add(0, time.get(i).getTime());
			table.get(i).add(1, "예약가능");
			table.get(i).add(2, "예약가능");
			table.get(i).add(3, "예약가능");
			table.get(i).add(4, "예약가능");
			table.get(i).add(5, "예약가능");
			table.get(i).add(6, "예약가능");
			table.get(i).add(7, "예약가능");
			table.get(i).add(8, "예약가능");
			table.get(i).add(9, "예약가능");
		}

		int i;

		for (FacilityReservVO facResVO2 : faciltyReservList) {

			log.info("hiyaho: " + facResVO2);

			for (i = 1; i < 10; i++) {

				if (facResVO2.getFaciNo().equals("FAC30" + i)) {
					if (facResVO2.getFacirsvTm().equals("14:00")) {
						table.get(0).add(i, facResVO2);
						break;
					}
					if (facResVO2.getFacirsvTm().equals("15:00")) {
						table.get(1).add(i, facResVO2);
						break;
					}
					if (facResVO2.getFacirsvTm().equals("16:00")) {
						table.get(2).add(i, facResVO2);
						break;
					}
					if (facResVO2.getFacirsvTm().equals("17:00")) {
						table.get(3).add(i, facResVO2);
						break;
					}
					if (facResVO2.getFacirsvTm().equals("18:00")) {
						table.get(4).add(i, facResVO2);
						break;
					}
					if (facResVO2.getFacirsvTm().equals("19:00")) {
						table.get(5).add(i, facResVO2);
						break;
					}
				}
			}

		}

		model.addAttribute("hiyahoDay", sDate);
		model.addAttribute("time", time);
		model.addAttribute("hiyaho", table);

		return "facilityReserv/Facility";

	}
	
	@GetMapping(value = "reserve", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String makeResvervation (@RequestParam String facirsvDt, @RequestParam String facirsvTm, @RequestParam String faciNo, @RequestParam String memId) throws ParseException {
		FacilityReservVO facilityReservVO = new FacilityReservVO();
		facilityReservVO.setFacirsvTm(facirsvTm);
		facilityReservVO.setMemId(memId);
		facilityReservVO.setFaciNo(faciNo);
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		Date date = simpleDate.parse(facirsvDt);
		facilityReservVO.setFacirsvDt(date);
		facilityReservService.insertFacReserv(facilityReservVO);
		return "success";
	}
	
	@GetMapping(value = "delete")
	@ResponseBody
	public String deleteReservation(@RequestParam String facirsvNo, @RequestParam String memId) {
		FacilityReservVO facilityReservVO = new FacilityReservVO();
		facilityReservVO.setFacirsvNo(facirsvNo);
		facilityReservVO.setMemId(memId);
		facilityReservService.deleteFacReserv(facilityReservVO);
		return "success";
	}
	
	@PostMapping(value = "/main" , produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<String> facirsvTimeList(String facirsvDt){
		List<String> dateTimeList = facilityReservService.facTimeList(facirsvDt);
		
		return dateTimeList;
	
}
	
}


























