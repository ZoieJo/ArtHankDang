package kr.or.arthakdang.subject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.arthakdang.subject.service.SubjectService;

@Controller
@RequestMapping("/subject")
public class SubjectController {

	@Autowired
	SubjectService subs;
	
	// 결과
	int rst = 0;
	
	/* 페이지 보여주기 */
	@GetMapping("/list")
	public String getSubList(Model model) {
		model.addAttribute("sublist", subs.selectSub());
		return "sub/list";
	}
	
	/* 삭제 */
	@PostMapping("/delete")
	public String postSubList(String subNo, RedirectAttributes reAtti) {
		String subNoList[] = subNo.split(",");
		rst = 0;
		if(subNoList.length>1) { // 여려개인 경우
			for (String no : subNoList) {
				rst += subs.deleteSub(no);
			}
		} else { // 단일인 경우
			rst = subs.deleteSub(subNo);
		}
		
		// 결과 메시지
		if(rst == 0) {
			reAtti.addAttribute("msg", "알 수 없는 오류가 발생하였습니다. 관리자에게 문의해 주세요!");
		} else {
			reAtti.addAttribute("msg", "삭제가 완료되었습니다.");
		}
		return "redirect:/subject/list";
	}
	
	/* 생성 */
	@PostMapping("/create")
	public String postSubCre(String subNm, RedirectAttributes reAtti) {
		rst = 0;
		rst = subs.insertSub(subNm);
		if(rst == 1) {
			reAtti.addFlashAttribute("msg", "새로운 과목이 생성되었습니다.");
		}else {
			reAtti.addAttribute("msg", "알 수 없는 오류가 발생하였습니다. 관리자에게 문의해 주세요!");
		}
		
		return "redirect:/subject/list";
	}
	
}
