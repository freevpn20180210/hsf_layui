package com.lyf.config;

import org.hibernate.dialect.MySQL5Dialect;
import org.hibernate.dialect.function.SQLFunctionTemplate;
import org.hibernate.type.StandardBasicTypes;

/**
 * MySQL5Dialect配置类
 * author:lyf
 * 20200605
 */
public class MySQL5LocalDialect extends MySQL5Dialect {

    public MySQL5LocalDialect() {
        super();
        registerFunction("convertGBK", new SQLFunctionTemplate(StandardBasicTypes.STRING, "convert(?1 using gbk)"));
    }
}
