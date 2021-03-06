package org.kosta.gat.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.kosta.gat.model.service.DonationService;
import org.kosta.gat.model.service.EntryService;
import org.kosta.gat.model.service.MemberService;
import org.kosta.gat.model.vo.member.MemberVO;
import org.kosta.gat.model.vo.post.donation.DonationPostVO;
import org.kosta.gat.model.vo.post.review.ReviewPostVO;
import org.kosta.gat.model.vo.post.takedonation.TakeDonationPostVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class EntryController {
	@Resource
	private EntryService entryService;
	@Resource
	private DonationService donationService;
	@Resource
	private MemberService memberService;

	/**
	 * 재능기부 참여하기 
	 * 작성이유 : 등록된 재능기부에 참여하기 위한 메소드
	 * 
	 * @author 조민경
	 */
	@RequestMapping(value = "addTakeDonation.do", method = RequestMethod.POST)
	public String addTakeDonation(String dpno, TakeDonationPostVO tdVO, HttpServletRequest request) {
		// getSession(false) : 있으면 기존 세션, 없으면 null
		HttpSession session = request.getSession(false);
		MemberVO mvo = null;
		if (session != null) {
			mvo = (MemberVO) session.getAttribute("mvo");
			if (mvo != null) {
				// 참여하는 회원VO set
				tdVO.setMemberVO(mvo);
			}
		}
		// 재능기부 글 VO 정보 가져오기
		DonationPostVO dpVO = donationService.readDonationDetail(dpno);
		// 회원이 참여하려는 재능기부VO set
		tdVO.setDonationPostVO(dpVO);
		if(tdVO.getCheerUpMessage().equals("") || tdVO.getCheerUpMessage()==null){
			tdVO.setCheerUpMessage(null);
		}
		// 참여하기 기능
		entryService.addTakeDonation(tdVO);
		request.getSession().setAttribute("mvo", memberService.checkId(tdVO.getMemberVO().getId()));
		return "redirect:donation/readDonationDetail.do?dpno="+dpno+"&tdNowPage=1&rpNowPage=1#dp_community";
	}

	/**
	 * 작성이유 : 참여활동 후기 작성
	 * 
	 * @author 조민경
	 */
	@RequestMapping(value = "addReview.do", method = RequestMethod.POST)
	public String addReview(String dpno, String tdno, ReviewPostVO rpVO, HttpServletRequest request) {		
		HttpSession session = request.getSession(false);
		MemberVO mvo = null;
		TakeDonationPostVO tdVO = new TakeDonationPostVO();
		if (session!=null) {
			mvo = (MemberVO)session.getAttribute("mvo");
			tdVO.setTdNo(Integer.parseInt(tdno));
			rpVO.setMemberVO(mvo);
			rpVO.setDpVO(donationService.readDonationDetail(dpno));
			rpVO.setTdpVO(tdVO);

			System.out.println("EntryController : "+rpVO);
			entryService.addReview(rpVO);
		}
		request.getSession().setAttribute("mvo", memberService.checkId(rpVO.getMemberVO().getId()));
		return "redirect:donation/readDonationDetail.do?dpno=" + dpno+"&tdNowPage=1&rpNowPage=1#dp_community";
	}
	
	
	
	
}
