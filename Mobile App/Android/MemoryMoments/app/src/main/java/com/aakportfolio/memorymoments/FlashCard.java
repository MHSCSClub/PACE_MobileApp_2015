package com.aakportfolio.memorymoments;

import android.media.Image;

/**
 * Created by andrew on 4/7/15.
 */
public class FlashCard {
    private String cardType;
    private String name;
    private String personInfo;
    private Image pic;

    public FlashCard(String cT, String n, String pI, Image im){
        cardType = cT;
        name = n;
        personInfo = pI;
        pic = im;
    }

    public void update(String cT, String n, String pI, Image im){
        cardType = cT;
        name = n;
        personInfo = pI;
        pic = im;
    }

    public String getCardType(){
        return cardType;
    }

    public String getName(){
        return name;
    }

    public String getPersonInfo(){
        return personInfo;
    }

    public Image getPic(){
        return pic;
    }

    public void setCardType(String newCardType){
        cardType = newCardType;
    }

    public void setName(String newName){
        name = newName;
    }

    public void setPersonInfo(String newPersonInfo){
        personInfo = newPersonInfo;
    }

    public void setPic(Image newPic){
        pic = newPic;
    }
}
