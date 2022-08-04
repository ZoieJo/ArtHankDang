package kr.or.arthakdang.framework.web.context;


import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
 
/**
 * @author hyeonseo
 * 서버 구동 시 log4jdbc 설정 properties 파일 경로를 설정해주는 클래스
 *
 */
public class Log4jdbcLog4j2ConfigListener implements ServletContextListener {
    
    /**
     * 
     */
    public Log4jdbcLog4j2ConfigListener() {
    }
 
    /**
     * @param sce ServletContextEvent
     * @see javax.servlet.ServletContextListener#contextInitialized(javax.servlet.ServletContextEvent)
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext sc = sce.getServletContext();
        String location = sc.getInitParameter("log4jdbcLog4j2ConfigLocation");
        
        if(location != null) {
            // 로그 메시지
            sc.log(":: 시스템 설정 변경 -> log4jdbc.log4j2.properties.file=" + location);
            
            String key = System.getProperty("log4jdbc.log4j2.properties.file");
            sc.log("기존 key : " + key);
            // System Property 설정 : log4jbc-log4j2 프로퍼티경로 변경 설정
            System.setProperty("log4jdbc.log4j2.properties.file", location);
            key = System.getProperty("log4jdbc.log4j2.properties.file");
            sc.log("변경된 key : " + key);
            
        } else {
            sc.log(":: 설정 변경 실패 -> 'log4jdbcLog4j2ConfigLocation' 이 없습니다. 기존 경로에서 로딩됩니다.");
        }
    }
 
    /**
     * @param sce
     * @see javax.servlet.ServletContextListener#contextDestroyed(javax.servlet.ServletContextEvent)
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
 
