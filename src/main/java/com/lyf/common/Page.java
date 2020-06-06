package com.lyf.common;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 分页类
 */
@NoArgsConstructor
@ToString
public class Page {
    @Getter
    @Setter
    private int page = 1;// 当前页
    @Getter
    @Setter
    private int limit = 10;// 每页记录数
    @Getter
    @Setter
    private int count;// 总记录数
    @Setter
    private int pages;// 总页数;

    //总页数=总记录数%每页记录数
    public int getPages() {
        return count % limit == 0 ? count / limit : count / limit + 1;
    }
}
