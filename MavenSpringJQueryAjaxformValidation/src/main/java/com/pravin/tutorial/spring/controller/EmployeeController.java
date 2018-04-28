package com.pravin.tutorial.spring.controller;

import java.util.Map;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pravin.tutorial.spring.model.Employee;
import com.pravin.tutorial.spring.model.EmployeeJsonRespone;

@Controller
public class EmployeeController {

    @GetMapping("/")
    public String employeeForm() {
	return "employeeForm";
    }

    @PostMapping(value = "/saveEmployee", produces = { MediaType.APPLICATION_JSON_VALUE })
    @ResponseBody
    public EmployeeJsonRespone saveEmployee(@ModelAttribute @Valid Employee employee, BindingResult bindingResult) {

	EmployeeJsonRespone jsonRespone = new EmployeeJsonRespone();
	if (bindingResult.hasErrors()) {
	    Map<String, String> errors = bindingResult.getFieldErrors()
		    .stream()
		    .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage));
	    jsonRespone.setValidated(false);
	    jsonRespone.setErrorMessages(errors);
	} else {
	    jsonRespone.setValidated(true);
	    jsonRespone.setEmployee(employee);
	}
	return jsonRespone;
    }
}
