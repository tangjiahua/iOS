//
//  main.swift
//  Homework_1
//
//  Created by 汤佳桦 on 2019/7/12.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
public class Solution {
    func alienOrder([String] words) -> String {
    boolean[][] graph = new boolean[26][26];
    int[] indegrees = new int[26];
    boolean[] alphabets = new boolean[26];
    int alphabetsCount = 0;
    char[] word =new char[0];
    for(int i=0; i<words.length; i++) {
    char[] prev = word;
    word = words[i].toCharArray();
    for(int j=0; j<word.length; j++) {
    if (!alphabets[word[j]-'a']) {
    alphabets[word[j]-'a'] = true;
    alphabetsCount ++;
    }
    }
    for(int j=0; j<Math.min(prev.length, word.length); j++) {
    if (prev[j] != word[j]) {
    if (!graph[prev[j]-'a'][word[j]-'a']) {
    graph[prev[j]-'a'][word[j]-'a'] = true;
    indegrees[word[j]-'a'] ++;
    }
    break;
    }
    }
    }
    char[] result = new char[alphabetsCount];
    int pos = 0;
    do {
    boolean changed = false;
    for(int i=0; i<alphabets.length; i++) {
    if (alphabets[i]) {
    if (indegrees[i] == 0) {
    result[pos++] = (char)(i+'a');
    changed = true;
    for(int j=0; j<graph[i].length; j++) {
    if (graph[i][j]) {
    indegrees[j] --;
    }
    }
    alphabets[i] = false;
    }
    }
    }
    if (!changed) break;
    } while (pos < result.length);
    return pos == result.length ? new String(result) : "";
    }
}

