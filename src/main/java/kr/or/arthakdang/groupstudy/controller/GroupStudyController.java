package kr.or.arthakdang.groupstudy.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.arthakdang.groupstudy.domain.GroupStudyMemInfoVO;
import kr.or.arthakdang.groupstudy.domain.GroupStudyVO;
import kr.or.arthakdang.groupstudy.domain.InteattchVO;
import kr.or.arthakdang.groupstudy.domain.SubjectVO;
import kr.or.arthakdang.groupstudy.service.GroupStudyService;
import kr.or.arthakdang.security.annotation.CurrentUser;
import kr.or.arthakdang.security.user.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class GroupStudyController {

	@Autowired
	private GroupStudyService groupStudyService;
	
	@GetMapping("/groupStudy/main")
	public String getGroupStudyMain(Model model, @CurrentUser CustomUser user) {
		String memId = user.getMember().getMemId();
//		List<GroupStudyVO> includeGroupStudyList = groupStudyService.includeGroupStudyList(memId);
//		model.addAttribute("includeGroupStudyList", includeGroupStudyList);
//		log.info("include > " + includeGroupStudyList);
		
		List<GroupStudyMemInfoVO> groupStudyMemInfoList = groupStudyService.selectGroupStudyNo(memId);
		model.addAttribute("groupStudyMemInfoList", groupStudyMemInfoList);
		
		List<SubjectVO> subjectList = groupStudyService.subjectList(); // 과목리스트
		model.addAttribute("subjectList", subjectList);
		model.addAttribute("memId", user.getMember().getMemId());
		model.addAttribute("user", user);
		List<GroupStudyVO> groupStudyList = groupStudyService.groupStudyAndAttchList();

		log.info("groupStudy"  + groupStudyList);
		model.addAttribute("groupStudyList", groupStudyList);
		return "groupstudy/groupStudy";
	}
	
	@PostMapping("/groupStudy/createGroupStudy")
	public String postCreateGroupStudy(Model model, GroupStudyVO groupStudyVO, MultipartFile uploadFile, InteattchVO inteattchVO, HttpSession session) {
		String uploadFolder = "D:\\workspace-sts-3.9.14\\ArtHakDang\\src\\main\\webapp\\resources\\image"; // 절대경로여서 수정 필 !
//		String uploadFolder = session.getServletContext().getRealPath("/resources/image");
//		log.info("getname" + file.getName());
//		log.info("getcontenttype" + file.getContentType());
//		log.info("getbyte" + file.getBytes().toString());
//		log.info("getsize" + file.getSize());
//		log.info("memId" +groupStudyVO.getMemId()); // 만든사람 이름
//		log.info("file" + file.getOriginalFilename()); // 진짜 파일 이름
		
		UUID uuid = UUID.randomUUID(); // 랜덤이름 생성
		String realFileName = uploadFile.getOriginalFilename(); // 진짜 파일 이름
		String fileName = uuid.toString() + "_" + realFileName;
		log.info("fileName > " + fileName);
		String fileExt = uploadFile.getOriginalFilename().split("\\.")[1]; // 확장자
		
		inteattchVO.setAttchNm(realFileName); // 실제 파일
		inteattchVO.setAttchPath(uploadFolder + "\\" + fileName);
		inteattchVO.setAttchExt(fileExt);
		inteattchVO.setAttchSz(uploadFile.getSize());
		inteattchVO.setAttchStdNm(fileName); // 저장된 파일 이름
		
		inteattchVO.setInteattchOd(1); // 순번인데 썸네일은 하나밖에 없어서 1 고정
		groupStudyVO.setInteattchVO(inteattchVO);
		File saveFile = new File(uploadFolder, fileName); // 랜덤생성한 아이디 저장
		
		try {
			uploadFile.transferTo(saveFile);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		model.addAttribute("groupStudyVO", groupStudyVO);

		int result = groupStudyService.createGroupStudy(groupStudyVO);
		
		return "redirect:/groupStudy/main";
	}
	
	@PostMapping("/groupStudy/joinGroupStudy")
	public String postJoinGroupStudy(GroupStudyMemInfoVO groupStudyMemInfoVO) {
		
		log.info("groupstudyMemInfoVO > " + groupStudyMemInfoVO);
		int result = groupStudyService.joinGroupStudy(groupStudyMemInfoVO);
		int result2 = groupStudyService.groupStudyPlusOne(groupStudyMemInfoVO);
		
		return "redirect:/groupStudy/main";
	}
	
	@PostMapping("/groupStudy/outGroupStudy")
	public String postOutGroupStudy(GroupStudyVO groupStudyVO) {
		
		int result = groupStudyService.outGroupStudy(groupStudyVO);
		int result2 = groupStudyService.groupStudyMinusOne(groupStudyVO);
//		int result3 = groupStudyService.deleteAttchImage(groupStudyVO);
		
		return "redirect:/groupStudy/main";
	}
	
	@PostMapping("/groupStudy/uploadFile")
	public String postUploadFile(Model model, MultipartFile[] multiFile, InteattchVO inteattchVO) {
		String uploadFolder = "D:\\workspace-sts-3.9.14\\ArtHakDang\\src\\main\\webapp\\resources\\upload";
//		String uploadFolder = session.getServletContext().getRealPath("/");
		
		List<String> uploadFileList = new ArrayList<String>();
		 for(MultipartFile multipartFile : multiFile) {
	            log.info("---------------------");
	            log.info("업로드 파일명 : " + multipartFile.getOriginalFilename());
	            log.info("업로드 파일 크기 : " + multipartFile.getSize());
	            UUID uuid = UUID.randomUUID();
	            
	            String fileName = uuid.toString() + "_" + multipartFile.getOriginalFilename();
	            inteattchVO.setAttchNm(multipartFile.getOriginalFilename());
	            inteattchVO.setAttchExt(multipartFile.getOriginalFilename().split("\\.")[1]);
	            
	            inteattchVO.setAttchPath(uploadFolder + "\\" + fileName);
	            inteattchVO.setAttchSz(multipartFile.getSize());
	            inteattchVO.setInteattchNo(inteattchVO.getInteattchNo()); // 그룹스터디번호와 첨부파일 번호 일치
	            inteattchVO.setInteattchOd(101);
	            inteattchVO.setMdMemId(inteattchVO.getRgMemId());
	            inteattchVO.setRgMemId(inteattchVO.getRgMemId());
	            inteattchVO.setAttchStdNm(fileName);
	            
	            //파일 객체를 통해 이렇게 하겠다..
	            File saveFile 
	            = new File(uploadFolder, fileName);
	            int result = groupStudyService.uploadFile(inteattchVO);
	            try {
	               multipartFile.transferTo(saveFile);
	               uploadFileList.add(fileName);
	            }catch(Exception ex) {
	               log.error(ex.getMessage());
	            }
	         }
		 model.addAttribute("uploadFileList",uploadFileList);

		 return "redirect:/groupStudy/main";
	}
	
	@PostMapping("/groupStudy/uploadFileList")
	public String postUploadFileList() {
		return "";
	}
}