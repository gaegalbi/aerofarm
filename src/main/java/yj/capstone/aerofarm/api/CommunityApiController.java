package yj.capstone.aerofarm.api;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import yj.capstone.aerofarm.controller.dto.PostDto;
import yj.capstone.aerofarm.domain.board.PostDetail;
import yj.capstone.aerofarm.service.CommunityService;

import javax.validation.Valid;

@RestController
@RequiredArgsConstructor
public class CommunityApiController {

    private final CommunityService communityService;

    // 글쓰기 페이지 작성 기능
    @PostMapping("/community/writing")
    public CreatePostResponse postSubmit (@RequestBody @Valid PostDto postDto, PostDetail postDetail) {
        PostDetail resultPost = communityService.postDetailJoin(postDetail);
        PostDto resultPostDto = new PostDto(postDto, resultPost);
        communityService.postJoin(resultPostDto);
        return new CreatePostResponse(postDto.getId());
    }

    @Data
    static class CreatePostResponse {
        private Long id;

        public CreatePostResponse(Long id) {
            this.id = id;
        }
    }
}
