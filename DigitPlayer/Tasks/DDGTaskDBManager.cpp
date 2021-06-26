//
//  DDGTaskDBManager.cpp
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/11/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#include "DDGTaskDBManager.hpp"
#include <iostream>


DDGTaskDBManager::DDGTaskDBManager()
{
}

DDGTaskDBManager::~DDGTaskDBManager()
{
}

DDGTaskDBManager& DDGTaskDBManager::getInstance()
{
    static DDGTaskDBManager instance;
    return instance;
}

//
#pragma mark -- interface
void DDGTaskDBManager::saveTask()
{
    using namespace std;
    
    cout << "Here we are in saveTask!" << endl;
}
