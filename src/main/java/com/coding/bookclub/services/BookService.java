package com.coding.bookclub.services;

import com.coding.bookclub.models.Book;
import com.coding.bookclub.repositories.BookRepository;
import org.apache.commons.text.WordUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Service
public class BookService {
    @Autowired
    BookRepository bookRepository;

    @Autowired
    UserService userService;

    public List<Book> findAllBooks(){
        return bookRepository.findAll();
    }

    public Book findOneBook(Long id) {
        Optional<Book> oneBook = bookRepository.findById(id);
        if(oneBook.isPresent()){
            return oneBook.get();
        }else{
            return null;
        }
    }

    public Book addOrUpdateBook(Book book, Long id) {
        book.setTitle(WordUtils.capitalizeFully(book.getTitle()));
        book.setAuthor(WordUtils.capitalizeFully(book.getAuthor()));
        book.setUser(userService.findUser(id));
        return bookRepository.save(book);
    }

    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }

//    public Book editBook(Book book) {
//        book.setTitle(WordUtils.capitalizeFully(book.getTitle()));
//        book.setAuthor(WordUtils.capitalizeFully(book.getAuthor()));
//        return bookRepository.save(book);
//    }
}
