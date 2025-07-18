package com.example.suhodan.userbadge;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserBadgeDAOImpl implements UserBadgeDAO {

    private static final String NAMESPACE = "userbadge.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public int insertBadgeForQualifiedUsers(int transaction_id) {
        return sqlSession.insert(NAMESPACE + "insertBadgeForQualifiedUsers", transaction_id);
    }
    
    @Override
    public String checkBadgeGranted(String user_id, int amount) {
        // MyBatis XML 매퍼 호출
        if (amount >= 50000) {
            return sqlSession.selectOne(NAMESPACE +"checkBadgeGranted", user_id);
        }
        return null;
    }
    
    @Override
    public String getBadgeLocationForUser(String user_id) {
        return sqlSession.selectOne(NAMESPACE + "getBadgeLocationForUser", user_id);
    }

}
