package com.example.demo.controller;

import com.example.demo.entity.Message;
import com.example.demo.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
public class Index {

    @Autowired
    private MessageRepository messageRepository;

    @GetMapping("/save/{text}")
    public String saveMessage(@PathVariable String text) {
        Message message = new Message();
        message.setText(text);
        messageRepository.save(message);
        return "done";
    }

    @GetMapping
    public List<String> getAllMessages(){
        return messageRepository.findAll().stream().map(Message::getText).collect(Collectors.toList());
    }
}
