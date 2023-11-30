package com.example.tools;

import java.time.Duration;
import java.time.Instant;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class TimeCalculator {

	public String timeAgo(Instant abs_time) {
		Instant now = Instant.now();
		Duration duration = Duration.between(abs_time, now);

		long seconds = duration.getSeconds();

		if (seconds < 60) { // 1분 미만
			return seconds + "초 전";
		} else if (seconds < 3600) { // 1시간 미만
			return duration.toMinutes() + "분 전";
		} else if (seconds < 86400) { // 1일 미만
			return duration.toHours() + "시간 전";
		} else if (seconds < 2592000) { // 1달 미만 (대략적인 계산, 정확한 달 계산을 원한다면 별도의 로직 필요)
            return duration.toDays() + "일 전";
		} else {
			// 1년 미만까지의 월 계산
			LocalDate startDate = LocalDate.ofInstant(abs_time, ZoneId.systemDefault());
			LocalDate endDate = LocalDate.ofInstant(now, ZoneId.systemDefault());
			Period period = Period.between(startDate, endDate);

			if (period.getYears() < 1) {
				int months = period.getMonths();
				return months <= 0 ? "1달 전" : months + "달 전"; // 0개월은 "1달 전"으로 표시
			} else {
				// 1년 이상인 경우, 필요에 따라 다른 포맷이나 처리가 필요할 수 있음
				return "1년 이상 전";
			}
		}
	}
	
	public String formatTimeKST(Instant abs_time) {
        // KST 시간대로 변환
        ZonedDateTime kstTime = abs_time.atZone(ZoneId.of("Asia/Seoul"));

        // 원하는 형식으로 포맷 (예: 오후 7:30)
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("a h:mm");
        return kstTime.format(formatter);
    }

}
