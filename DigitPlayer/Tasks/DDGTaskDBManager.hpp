//
//  DDGTaskDBManager.hpp
//  DigitPlayer
//
//  Created by HS_macOSSierra on 12/11/17.
//  Copyright © 2017 Mavericks-Hackintosh. All rights reserved.
//

#ifndef DDGTaskDBManager_hpp
#define DDGTaskDBManager_hpp

#include <stdio.h>
//#include "SQLite3Cpp.hpp"


class DDGTaskDBManager
{
public:
    
    static DDGTaskDBManager& getInstance();
    virtual ~DDGTaskDBManager();
    
    //
    // Interface
    //
    void createProTable();
    void addProject();
    void saveTask();
    
private:
    
    DDGTaskDBManager();
    DDGTaskDBManager(const DDGTaskDBManager& rhs);
    DDGTaskDBManager& operator=(const DDGTaskDBManager& rhs);
    
    //
};
#endif /* DDGTaskDBManager_hpp */
