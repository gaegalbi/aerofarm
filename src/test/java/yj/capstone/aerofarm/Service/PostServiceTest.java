package yj.capstone.aerofarm.Service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.form.PostForm;
import yj.capstone.aerofarm.form.SaveMemberForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.board.PostCategory;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.service.PostService;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Transactional
public class PostServiceTest {

    @Autowired
    PostService postService;

    @Test
    void create_post() {
        SaveMemberForm saveMemberForm = new SaveMemberForm();
        saveMemberForm.setEmail("abc123@naver.com");
        saveMemberForm.setPassword("1234");
        saveMemberForm.setPhoneNumber("010-1234-1234");
        saveMemberForm.setNickname("qqc");
        Member member = Member.saveMemberFormBuilder().saveMemberForm(saveMemberForm).build();

        PostForm postForm = new PostForm();
        postForm.setCategory("FREE");
        postForm.setTitle("제목 1");

        Post post = postService.createBasicPost(member, postForm);

        assertThat(post.getWriter()).isEqualTo(member);
        assertThat(post.getCategory()).isEqualTo(PostCategory.FREE);
        assertThat(post.getContent().getContents()).isEqualTo("내용1");
    }
}
