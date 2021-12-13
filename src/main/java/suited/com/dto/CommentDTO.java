package suited.com.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class CommentDTO {
	private int seq_review;
	private String nickname;
	private String content;
	private String written_comment_date;
	private String product_code;
	private String id;
	
	public CommentDTO() {}
	
	public String toStringDate(long date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		return sdf.format(date);
	}

	public int getSeq_review() {
		return seq_review;
	}

	public void setSeq_review(int seq_review) {
		this.seq_review = seq_review;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWritten_comment_date() {
		return written_comment_date;
	}

	public void setWritten_comment_date(String written_comment_date) {
		this.written_comment_date = written_comment_date;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public CommentDTO(int seq_review, String nickname, String content, long written_comment_date, String product_code,
			String id) {
		super();
		this.seq_review = seq_review;
		this.nickname = nickname;
		this.content = content;
		this.written_comment_date = toStringDate(written_comment_date);
		this.product_code = product_code;
		this.id = id;
	}
	
	public CommentDTO(int seq_review, String nickname, String content, String written_comment_date, String product_code,
			String id) {
		super();
		this.seq_review = seq_review;
		this.nickname = nickname;
		this.content = content;
		this.written_comment_date = written_comment_date;
		this.product_code = product_code;
		this.id = id;
	}
}
