package yj.capstone.aerofarm.config.auth.dto;

import lombok.Getter;
import lombok.ToString;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.member.MemberRole;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

@Getter
@ToString
public class UserDetailsImpl implements UserDetails, OAuth2User {

    private Member member;
    private Map<String, Object> attributes;
    private Collection<GrantedAuthority> authorities = new ArrayList<>();

    public void updateMember(Member member) {
        this.member = member;
    }

    public UserDetailsImpl(Member member) {
        this.member = member;
        setAuthorities(member.getRoles());
    }

    public UserDetailsImpl(Member member, Map<String, Object> attributes) {
        this.member = member;
        this.attributes = attributes;
        setAuthorities(member.getRoles());
    }

    private void setAuthorities(List<MemberRole> roles) {
        for (MemberRole role : roles) {
            authorities.add(new SimpleGrantedAuthority(role.getRole().name()));
        }
    }

    @Override
    public Map<String, Object> getAttributes() {
        return this.attributes;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.authorities;
    }

    @Override
    public String getPassword() {
        return this.member.getPassword();
    }

    @Override
    public String getUsername() {
        return this.member.getEmail();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return this.member.isVerify();
    }

    @Override
    public String getName() {
        return this.member.getEmail();
    }
}
