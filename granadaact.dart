import 'dart:developer';
import 'dart:io';

class Library with searchIndex, mainMenuProcesses{
  var allBooks, lentBooks, bookList=[], userList=[];
  List genres=["Computer Science", "Philosophy", "Pure Science", "Art and Recreation", "History"];

  Library(){
    allBooks=0;
    lentBooks=0;
  }

  int numOfBooks(){
    return allBooks;
  }

  int numOfLent(){
    return lentBooks;
  }

  void addBook(String title, String author, String genre, String ISBN){
    var book=new Books(title, author, genre, ISBN);
    bookList.add(book);
    allBooks++;
  }

  void lendBook(int userIndex){
    for(var doAddBook='1';doAddBook!='2';){

      stdout.write("\n(1)Add book ISBN\n(2)Finish adding\nType choice:");
      doAddBook=stdin.readLineSync()!;

      if(doAddBook=='1'){
        
        for(int bookIndex=-1;bookIndex==-1;){
          stdout.write("\nEnter book ISBN: ");
          String ISBNbyUser=stdin.readLineSync()!;
          bookIndex=findBookIndex(bookList, ISBNbyUser);

          if(bookIndex==-1)
            print("Book not found. Please enter ISBN again.");
          else if(bookList[bookIndex].status==0)
            print("Book is currently borrowed by someone else.");
          else{
            userList[userIndex].borrowedBooks.add(bookList[bookIndex]);
            bookList[bookIndex].status=0;
            lentBooks++;
          }
        }
      }
      else if(doAddBook=='2')
        print("\nBooks added to borrow list.\n");
      else
        print("Invalid choice. Please try again.");
    }
  }

 
  void acceptReturn(int userIndex){
    print("\nReturned books: ");
    if(userList[userIndex].borrowedBooks.length!=0){
      for(int i=0;i<userList[userIndex].borrowedBooks.length;){
        int bookIndex=findBookIndex(bookList, userList[userIndex].borrowedBooks[i].ISBN);
        userList[userIndex].borrowedBooks.removeAt(0);
        bookList[bookIndex].status=1;
        lentBooks--;
        print("\t${bookList[bookIndex].title} by ${bookList[bookIndex].author}");
      }
    }
    else
      print("\nNo borrowed books in your record.");
  }
  
  void newUser(String fullName, String address){
    var user=new User(fullName, address);
    userList.add(user);
  }
}

class Books{
  late String title;
  late String author;
  late String genre;
  late String ISBN;
  late int status; //0=borrowed, 1=available
  var booksBorrowed=[];

  Books(title, author, genre, ISBN){
    this.title=title;
    this.author=author;
    this.genre=genre;
    this.ISBN=ISBN;
    status=1; //status is immediately given value of 1 since it is available once added to collection
  }
}

class User{
  late String fullName;
  late String address;
  var borrowedBooks=[];
  User(String fullName, String address){
    this.fullName=fullName;
    this.address=address;
  }
}

  int findBookIndex(var listOfBooks, String ISBN){
    for(int i=0;i<listOfBooks.length;i++){
      if(listOfBooks[i].ISBN==ISBN)
        return i;
    }
    return -1;
  }


  int findUserIndex(var listOfUsers, String fullName, String address){
    for(int i=0;i<listOfUsers.length;i++){
      if(listOfUsers[i].fullName==fullName && listOfUsers[i].address==address)
        return i;
    }
    return -1;
  }
}