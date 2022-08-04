package kr.or.arthakdang.crelecture.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.crelecture.domain.CursVO;
import kr.or.arthakdang.crelecture.domain.InteattchVO;
import kr.or.arthakdang.crelecture.domain.LecturePlanVO;
import kr.or.arthakdang.crelecture.domain.SearchInfoVO;
import kr.or.arthakdang.crelecture.domain.TcrDtlVO;
import kr.or.arthakdang.crelecture.service.LectureService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/crelecture")
@Slf4j
public class LectureEmployeeController {
	
	@Autowired
	LectureService ls;
	
	/* [직원] 강의 계획서 리스트 페이지 */
	@GetMapping("/employee")
	public String getEnrollLecture(Model model, SearchInfoVO siVO) {
		// [리스트 페이지] 강의 계획서 리스트 뿌려주기
		model.addAttribute("lecPnAllList", ls.selectPnAllList(siVO));
		
		// [폼 페이지] 승인된 강의 계획서 번호 리스트 뿌리기
		model.addAttribute("pnNoList", ls.selectPnNo());
		
		return "lectureCre/enrollForm";
	}
	/* [직원] 강의 계획서 리스트 페이지 */
	@PostMapping("/employee/search")
	public String postEnrollSearch(Model model, SearchInfoVO siVO) {
		// [리스트 페이지] 강의 계획서 리스트 뿌려주기
		model.addAttribute("lecPnAllList", ls.selectPnAllList(siVO));
		// [폼 페이지] 승인된 강의 계획서 번호 리스트 뿌리기
		model.addAttribute("pnNoList", ls.selectPnNo());
		return "lectureCre/enrollForm";
	}
	
	/* [직원] 계획서 번호 정보 매칭시키기 AJAX */
	@GetMapping(value = "/employee/pndtl", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public LecturePlanVO getpndtl(String no) {
		return ls.selectOkPnVO(no);
	}

	/* [직원] 강의 상세보기 페이지 정보 AJAX */
	@GetMapping(value = "/employee/dtl", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public LecturePlanVO getCursPnDtl2(@RequestParam String curspnNo) {
		return ls.selectPnDtl(curspnNo);
	}
	
	/**
	 * [직원] 강의 썸네일 저장 함수
	 * @param multipart 멀티파트 파일
	 * @param id 해당 로그인한 아이디
	 * @param request 서블릿 리퀘스트
	 * @return
	 */
	public String postPreShow(MultipartFile uploadFile, String id, HttpServletRequest request) {
		
		InteattchVO intaVO = new InteattchVO(); // 저장할 파일
		String msg = null; // 결과 메시지
		
		String folderPath = "/resources/Thumbnail";
		log.info(folderPath);
		
		UUID uuid = UUID.randomUUID(); // 랜덤이름 생성
		String realFileNm = uploadFile.getOriginalFilename();
		String fileNm = uuid.toString() + "_" + realFileNm;
		String fileExt = uploadFile.getOriginalFilename().split("\\.")[1]; // 확장자		
		
		intaVO.setInteattchOd(1); // 수강계획 하나당 파일 하나만 업로드
		intaVO.setAttchPath("/resources/Thumbnail/" + fileNm); // 파일 경로
		intaVO.setAttchNm(realFileNm); // 실제파일이름
		intaVO.setAttchStdNm(fileNm); // 저장된파일이름
		intaVO.setAttchExt(fileExt); // 확장자
		intaVO.setAttchSz(uploadFile.getSize()); // 파일크기
		intaVO.setRgMemId(id); // 입력자
		intaVO.setMdMemId(id); // 수정자
		
		// DB에 파일 정보저장
		ls.insertThumbnail(intaVO);
		
		// 파일 실제로 저장
		String realPath = request.getSession().getServletContext().getRealPath("/") + folderPath;
		log.info(realPath);
		File saveFile = new File(realPath, fileNm);
		try {
			uploadFile.transferTo(saveFile);
			
			//섬네일 만들기 시작 ------------
			// /uploadAjax를 통해 이미지를 업로드 하면 
			// 1) 원본이미지 파일 저장
			// 2) 섬네일(s_원본이미지 파일) 파일 생성
			// but) 일반 파일은 원본 파일 저장
			//이미지인지 체킹
			if(checkImageType(saveFile)) {	//이미지인 경우
				//4) vo객체의 이미지 여부 setting
//				attachFileVo.setImage(true);
				//썸네일 => s_이미지파일명(바이너리 파일 생성)
				FileOutputStream thumbnail = 
						new FileOutputStream(
							new File(realPath, "s_" + fileNm)
								);
				//InputStream과 java.io.File 객체를 이용하여 
				//썸네일 파일 생성. width:100px, height:100px;
				Thumbnailator.createThumbnail(
						uploadFile.getInputStream(),thumbnail,100,100
						);
				thumbnail.close();
				
			}
			//썸네일 만들기 끝 ------------
			
			return msg = "ok";
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	/* [직원] 강의 등록*/
	@PostMapping("/employee")
	public String postEnrollLecture(@CurrentUser CustomUser user, RedirectAttributes reAttri,
			CursVO cursVO, MultipartFile tempPicture, HttpServletRequest request) {
		String myId = user.getUsername(); // 내 아이디
		
		// [수강등록] 과목 번호 가져오기
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ getTcrId "+cursVO.getTcrId());
		TcrDtlVO tdv = ls.selectSubject(cursVO.getTcrId());
		cursVO.setSubNo(tdv.getSubNo());
		
		// [수강등록] 강의계획번호 수정
//		cursVO.setCurspnNo("수강등록 강의계획번호@@@@@@@@@@@@@@@@@@@ "+ cursVO.getCurspnNo().split(","));
		String pnNo = cursVO.getCurspnNo();
		log.info("@@@@@@@@@@@@@@@@ 야호 @@@@@@@@@@@@@@ " + pnNo);
//		String pnNo = cursVO.getCurspnNo().split(",")[4];
		cursVO.setCurspnNo(pnNo);
		log.info("값 확인 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ " + cursVO.getCurspnNo());
		
		// [수강등록]
		int rst = ls.insertCurs(cursVO);
		
		// [수강시간상세등록]
		log.info("@@@@@@@@@@@@@ 요일 값 체크 " + cursVO.getCursDay());
		String days[] = cursVO.getCursDay().split(",");
		log.info("@@@@@@@@@@@@@ 요일 값 길이 " + days.length);
		
		if(days.length>1) { // 요일이 여려개인 경우
			for (String day : days) {
				cursVO.setCursDay(day);
				// log.info("@@@@@@@@@@@@@@@@@ 강의 시간 정보(여러개) " + cursVO);
				rst += ls.insertCursTM(cursVO);
			}
		} else { // 단일인 경우
			rst += ls.insertCursTM(cursVO);
			// log.info("@@@@@@@@@@@@@@@@@ 강의 시간 정보(단일) " + cursVO);
		}
		
		// [파일DB에 저장]
		if (postPreShow(tempPicture, myId, request).equals("ok")) {
			log.info("파일 업로드 성공");
		} else {
			log.info("파일 업로스 실패");
		}
		
		if(rst > 1) {
			reAttri.addFlashAttribute("msg", "수강이 성공적으로 등록되었습니다.");
		} else if(rst == 1) {
			reAttri.addFlashAttribute("msg", "어느 할 부분에서 오류가 났습니다. 관리자에게 문의해주세요~");
		} else {
			reAttri.addFlashAttribute("msg", "알 수 없는 오류로 인해 강의를 등록 할 수 없습니다. 관리자에게 문의해주세요~");
		}
		
		return "redirect:/crelecture/employee";
	}
	
	//이미지의 경우에만 섬네일 제작
	private boolean checkImageType(File file) {
		//MIME 타입을 통해 이미지 여부 확인
		//file.toPath() : 파일 객체를 path객체로 변환
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//MIME 타입 정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일은 이미지가 아니다.
		return false;
	}
	
}
