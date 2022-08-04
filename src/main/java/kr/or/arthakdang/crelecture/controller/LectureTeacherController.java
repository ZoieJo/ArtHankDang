package kr.or.arthakdang.crelecture.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.crelecture.domain.InteattchVO;
import kr.or.arthakdang.crelecture.domain.LecturePlanVO;
import kr.or.arthakdang.crelecture.domain.SearchInfoVO;
import kr.or.arthakdang.crelecture.service.LectureService;
import kr.or.arthakdang.domain.CurspnVO;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/crelecture")
@Slf4j
public class LectureTeacherController {
	
	@Autowired
	LectureService ls;
	
	/* [교원] 강의 계획서 등록 페이지 */
	@GetMapping("/teacher")
	public String getPlanLecture(Model model, @CurrentUser CustomUser user) {
		SearchInfoVO siVO = new SearchInfoVO();
		siVO.setTcrId(user.getUsername());
		siVO.setKeyword(null);
		siVO.setType(null);
		
		// 계획서 정보
		model.addAttribute("lecPnList", ls.selectPnList(siVO));
		// 강의실 정보
		model.addAttribute("faciInfo", ls.selectFaciInfo());
		// 유저 아이디
		model.addAttribute("myId", user.getUsername());
		
		return "lectureCre/planForm";
	}
	
	/* [교원] 강의 계획서 리스트 페이지 검색 */
	@PostMapping("/teacher/search")
	public String postCursPnSearch(Model model, @CurrentUser CustomUser user, SearchInfoVO siVO) {
		// 계획서 정보
		siVO.setTcrId(user.getUsername());
		model.addAttribute("lecPnList", ls.selectPnList(siVO));
		
		// 강의실 정보
		model.addAttribute("faciInfo", ls.selectFaciInfo());
		// 유저 아이디
		model.addAttribute("myId", user.getUsername());
		
		return "lectureCre/planForm";
	}
	
	/* [교원] 강의 상세보기 페이지 정보 AJAX */
	@GetMapping(value = "/teacher/dtl", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public LecturePlanVO getCursPnDtl(@RequestParam String curspnNo) {
		return ls.selectPnDtl(curspnNo);
	}
	
	/* [교원] 강의 계획서 삭제 AJAX */
	@PostMapping(value = "/teacher/delete", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String postCursPnDelete(@RequestBody Map<String, ArrayList<String>> data) {
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 아작스로 넘어온 맵 : " + data);
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 아작스로 넘어온 값 : " + data.get("curspnNoList"));
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 아작스로 넘어온 크기 : " + data.get("curspnNoList").size());
		
		String msg = "강의 계획서를 취소하는 도중 문제가 발생하였습니다. 관리자에게 문의해주세요.";
		int rst = 0;
		ArrayList<String> pnNoList = data.get("curspnNoList");
		
		if(pnNoList.size() > 1) {
			for (String pnNo : pnNoList) {
				rst += ls.deleteCurspn(pnNo);
			}
		} else {
			rst += ls.deleteCurspn(pnNoList.get(0));
		}
		if(rst>0) {msg = "강의 계획서 제출을 취소하였습니다.";}
		
		return msg;
	}
	
	/* [교원] 강의 계획서 등록폼 전송 */
	@PostMapping("/teacher")
	public String postPlanLecture(RedirectAttributes reAttri, LecturePlanVO lecpnVO, 
			MultipartFile uploadFile, InteattchVO intaVO, HttpServletRequest request) {
		 if (!uploadFile.isEmpty()) {
			 
	        // 실제 파일 저장하는 공간이 있는지 파악
	        String folderPath = "C:/upload/curspnFile";
	        File makeFolder = new File(folderPath);
	        // folderPath의 디렉토리가 존재하지 않을경우 디렉토리 생성.
	        if(!makeFolder.exists()) {
	            makeFolder.mkdir();  // 폴더를 생성합니다.
	            log.info("폴더를 생성합니다.");
	            // 정성적으로 폴더 생성시 true를 반환합니다.
	            log.info("폴더가 존재하는지 체크 true/false : " + makeFolder.exists());
	        } else {
	            log.info("이미 해당 폴더가 존재합니다.");
	        }
	        
			// 파일 업로드 실행
//			String folderPath2 = "/resources/upload/curspnFile";
			UUID uuid = UUID.randomUUID(); // 랜덤이름 생성
			String realFileNm = uploadFile.getOriginalFilename();
			String fileNm = uuid.toString() + "_" + realFileNm;
			String fileExt = uploadFile.getOriginalFilename().split("\\.")[1]; // 확장자
			
			log.info("realFileNm : " + realFileNm + ", fileNm : " + fileNm + ", fileExt : " + fileExt);
			
			intaVO.setInteattchOd(1); // 수강계획 하나당 파일 하나만 업로드
			intaVO.setAttchPath(folderPath + "/" + fileNm); // 파일 업로드 경로
			intaVO.setAttchNm(realFileNm); // 실제파일이름
			intaVO.setAttchStdNm(fileNm); // 저장된파일이름
			intaVO.setAttchExt(fileExt); // 확장자
			intaVO.setAttchSz(uploadFile.getSize()); // 파일크기
			intaVO.setRgMemId(lecpnVO.getTcrId()); // 입력자
			intaVO.setMdMemId(lecpnVO.getTcrId()); // 수정자
			
			
			File saveFile = new File(folderPath, fileNm);
			
			try {
				uploadFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error("파일 업로드 오류 발생!!!(계획서 올리기)@@@@@@@@@@@@ " + e.getMessage());
				reAttri.addFlashAttribute("msg", "계획서를 전달하지 못했습니다. 관리자에게 문의해주세요.");
				return "redirect:/lectureCre/teacher";
			}
		}
		
		// 강의 계획 넣기
		int rst = ls.insertLecPn(lecpnVO);
		
		// 파일 정보 저장
		ls.insertFile(intaVO);
		
		if(rst==1) {
			reAttri.addFlashAttribute("msg", "작성이 완료되었습니다.");
		} else{
			reAttri.addFlashAttribute("msg", "알 수 없는 오류가 발생했습니다. 관리자에게 문의해주세요.");
		}
		return "redirect:/crelecture/teacher";
	}

	/* [교원] 강의 계획서 수정 */
	@PostMapping("/teacher/update")
	public String postCurspnUpdate(LecturePlanVO lecPnVO, RedirectAttributes reAttri) {
		String msg = "강의 계획서를 변경하는 도중 문제가 발생하였습니다.";
		int rst = 0;
		rst = ls.updateCurspn(lecPnVO);
		if(rst==1) {
			msg = "강의 계획서가 성공적으로 변경되었습니다.";
		}
		reAttri.addFlashAttribute("mgs", msg);
		return "redirect:/crelecture/teacher";
	}
	
	
	/* 하드코딩 업뎃 */
	@GetMapping("/teacher/testUpdate")
	public String getTestUpdate() {
		ls.updateJava();
		return "redirect:/crelecture/teacher";
	}
	
}
