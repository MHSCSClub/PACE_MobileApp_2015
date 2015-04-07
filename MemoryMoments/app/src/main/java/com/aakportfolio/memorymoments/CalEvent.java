package com.aakportfolio.memorymoments;
import java.util.*;

/**
 * Created by rhea on 4/7/2015.
 */
public class CalEvent {
    private ArrayList <FlashCard> flashcards;
    private String name;
    private String description;
    private GregorianCalendar start;
    private GregorianCalendar end;

    public CalEvent(String n, String d, ArrayList<FlashCard> f, GregorianCalendar s, GregorianCalendar e) {
        name = n;
        description = d;
        flashcards = f;
        start = s;
        end = e;
    }

    public void setName(String n) {
        name = n;
    }

    public String getName() {
        return name;
    }

    public void setDescription(String d) {
        description = d;
    }

    public String getDescription() {
        return description;
    }

    public void setStart(GregorianCalendar s) {
        start = s;
    }

    public GregorianCalendar getStart() {
        return start;
    }

    public void setEnd(GregorianCalendar e) {
        end = e;
    }

    public GregorianCalendar getEnd() {
        return end;
    }

    public void setFlashcards(ArrayList<FlashCard> f) {
        flashcards = f;
    }

    public ArrayList<FlashCard> getFlashcards() {
        return flashcards;
    }

    public void addItemToFlashcards(FlashCard fc) {
        flashcards.add(FlashCard fc);
    }
}
