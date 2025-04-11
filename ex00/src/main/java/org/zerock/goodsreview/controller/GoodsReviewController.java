package org.zerock.goodsreview.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.goodsreview.service.GoodsReviewService;
import org.zerock.goodsreview.vo.GoodsReviewVO;
import org.zerock.member.vo.LoginVO;
import org.zerock.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@RestController
// sitemesh에 적용안되는 uri 사용 - 이유는 화면에 구성하는 uri가 아니기 때문이다.
@RequestMapping("/goodsreview")
@Log4j
public class GoodsReviewController {

	// 자동DI
	@Autowired
	@Qualifier("goodsReviewServiceImpl")
	private GoodsReviewService service;
	
	
	// 1.리스트 - get
	@GetMapping(value = "/list.do")
	// 리턴 type은 String(uri)가 jsp에 넘어갈 자료를 생각해야 한다.
	// 리뷰리스트, 페이지정보 - 두가지의 자료형이 틀리다. -> map
	public ResponseEntity<Map<String, Object>> 
		list(PageObject pageObject, Long no) {
		log.info("list - page : " + pageObject.getPage() + ", no : " + no);
		// DB에서 데이터(list)를 가져와서 넘겨줍니다.
		// pageObject 넘겨줍니다.
		List<GoodsReviewVO> list = service.list(pageObject, no);
		
		// 데이터를 전달할 map 객체 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("pageObject", pageObject);
		
		// list 와 pageObject의 데이터 확인
		// map으로 해서 데이터가 나오면 그냥사용하면 되고
		// 주소가 나오면 각각 출력하도록 작성 : map.list, map.pageObject;
		log.info("After map : " + map);
				
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	
	// 2. 일반게시판 리뷰 쓰기 - write - post
	@PostMapping(value = "/write.do", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> write(
			GoodsReviewVO vo,
			HttpSession session) throws Exception {
	    // 데이터 처리
//	    GoodsReviewVO vo = new GoodsReviewVO();
//	    vo.setTitle(title);
//	    vo.setContent(content);
	    vo.setId(getId(session));

	    service.write(vo);
	    return new ResponseEntity<>("리뷰 등록이 완료되었습니다.", HttpStatus.OK);
	}
	
	
	// 3. 일반게시판 리뷰 수정 - update - post
	@PostMapping(value = "/update.do", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> update(@RequestBody GoodsReviewVO vo, HttpSession session) throws Exception {
		log.info("update.do ---------------------------------");
		
		// 로그인 되어야 사용 가능
		vo.setId(getId(session));
		
		// 수정 처리
		Integer result = service.update(vo);
		
		if (result == 1) {
			return new ResponseEntity<String>("리뷰가 수정되었습니다.", HttpStatus.OK);
		}
		
		return new ResponseEntity<String>("리뷰가 수정되지 않았습니다.", HttpStatus.BAD_REQUEST);
	}
	
	
	// 4. 일반 게시판 리뷰 삭제 - delete - get
	@GetMapping(value = "/delete.do", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> delete(@RequestParam Long rno, HttpSession session) throws Exception {
	    log.info("delete.do --------------------------------------");
	    
	    // 로그인되어 있어야 삭제할 수 있습니다.
	    String id = getId(session);
	    
	    GoodsReviewVO vo = new GoodsReviewVO();
	    
	    vo.setRno(rno);
	    vo.setId(id);
	    
	    Integer result = service.delete(vo);
	    if (result == 1) {
	        return new ResponseEntity<>("리뷰가 삭제되었습니다.", HttpStatus.OK);
	    }
	    return new ResponseEntity<>("리뷰가 삭제되지 않았습니다.", HttpStatus.BAD_REQUEST);
	}
	
	
//	private String getId(HttpSession session) {
//		// LoginVO vo = (LoginVO) session.getAttribute("login");
//		// String id = vo.getId();
//		// 강제 로그인 처리를 합니다. - 테스트를 위해서
//		return "test1";
//	}
	
	private String getId(HttpSession session) throws Exception {
	    LoginVO loginVO = (LoginVO) session.getAttribute("login");
	    if (loginVO != null) {
	        return loginVO.getId();
	    }
	    throw new Exception("로그인이 필요합니다.");
	}
}