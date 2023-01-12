package com.coding.bookclub.controllers;

import com.coding.bookclub.models.Book;
import com.coding.bookclub.models.LoginUser;
import com.coding.bookclub.models.User;
import com.coding.bookclub.repositories.UserRepository;
import com.coding.bookclub.services.BookService;
import com.coding.bookclub.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.validation.constraints.Pattern;

@Controller
public class HomeController {
     @Autowired
     private UserService userServ;

     @Autowired
     private BookService bookServ;
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("newLogin", new LoginUser());
        return "login.jsp";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser,
                           BindingResult result, Model model, HttpSession session) {
        userServ.register(newUser, result);
        if(result.hasErrors()) {
            model.addAttribute("newLogin", new LoginUser());
            return "login.jsp";
        }else{
            session.setAttribute("UserId", newUser.getId());
            session.setAttribute("firstName", newUser.getFirstName());
            session.setAttribute("lastName", newUser.getLastName());
            return "redirect:/home";
        }
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin,
                        BindingResult result, Model model, HttpSession session) {
         User user = userServ.login(newLogin, result);
         if(result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "login.jsp";
         }else{
             session.setAttribute("UserId", user.getId());
             session.setAttribute("firstName", user.getFirstName());
             session.setAttribute("lastName", user.getLastName());
             return "redirect:/home";
         }
    }

    @GetMapping("/home")
    public String home(Model model, HttpSession session){
        if(session.getAttribute("UserId") == null){
            return "redirect:/";
        }
        model.addAttribute("books", bookServ.findAllBooks());
        model.addAttribute("id", session.getAttribute("UserId"));
        model.addAttribute("firstName", session.getAttribute("firstName"));
        model.addAttribute("lastName", session.getAttribute("lastName"));
        return "dashboard.jsp";
    }

    @GetMapping("/books/new")
    public String addBook(@ModelAttribute("newBook")Book book, Model model, HttpSession session){
        if(session.getAttribute("UserId") == null){
            return "redirect:/";
        }
        model.addAttribute("sessionId", session.getAttribute("UserId"));
        return "addBook.jsp";
    }

    @PostMapping("/books/new")
    public String processBook(@Valid @ModelAttribute("newBook")Book book, BindingResult result, HttpSession session){
        if(result.hasErrors()){
            return "addBook.jsp";
        }
        bookServ.addOrUpdateBook(book, (Long) session.getAttribute("UserId"));
        return "redirect:/home";
    }

    @GetMapping("/books/{bookId}")
    public String showBook(@PathVariable("bookId") Long id, Model model, HttpSession session){
        if(session.getAttribute("UserId") == null){
            return "redirect:/";
        }
        model.addAttribute("book", bookServ.findOneBook(id));
        model.addAttribute("id", session.getAttribute("UserId"));
        return "show.jsp";
    }

    @GetMapping("/books/edit/{id}")
    public String editBook(@PathVariable("id")Long id,@ModelAttribute("editBook")Book book, Model model, HttpSession session){
        if(session.getAttribute("UserId") == null){
            return "redirect:/";
        }
        Book aBook = bookServ.findOneBook(id);
        model.addAttribute("editBook", aBook);
        return "editBook.jsp";
    }

    @PutMapping("/books/edit/{id}")
    public String processBook(@PathVariable("id")Long id,@Valid @ModelAttribute("editBook")Book book,BindingResult result, HttpSession session){
        if(result.hasErrors()){
            return "editBook.jsp";
        }
        bookServ.addOrUpdateBook(book,(Long) session.getAttribute("UserId"));
        return "redirect:/home";
    }

    @DeleteMapping("/books/{id}")
    public String deleteBook(@PathVariable("id")Long id){
        bookServ.deleteBook(id);
        return "redirect:/home";
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }

}

