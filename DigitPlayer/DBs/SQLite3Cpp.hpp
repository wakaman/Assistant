////////////////////////////////////////////////////////////////////////////////
// CppSQLite3 - A C++ wrapper around the SQLite3 embedded database library.
//
// Copyright (c) 2004 Rob Groves. All Rights Reserved. rob.groves@btinternet.com
// 
// Permission to use, copy, modify, and distribute this software and its
// documentation for any purpose, without fee, and without a written
// agreement, is hereby granted, provided that the above copyright notice, 
// this paragraph and the following two paragraphs appear in all copies, 
// modifications, and distributions.
//
// IN NO EVENT SHALL THE AUTHOR BE LIABLE TO ANY PARTY FOR DIRECT,
// INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST
// PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION,
// EVEN IF THE AUTHOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// THE AUTHOR SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE. THE SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF
// ANY, PROVIDED HEREUNDER IS PROVIDED "AS IS". THE AUTHOR HAS NO OBLIGATION
// TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
//
// V3.0		03/08/2004	-Initial Version for sqlite3
//
// V3.1		16/09/2004	-Implemented getXXXXField using sqlite3 functions
//						-Added CppSQLiteDB3::tableExists()
////////////////////////////////////////////////////////////////////////////////
#ifndef SQLITE3CPP_H		//CppSQLite3_H
#define SQLITE3CPP_H		//CppSQLite3_H

#include <sqlite3.h>


namespace SQLite3
{
	//
	class Exception
	{

	public:

		Exception(const int nErrCode, char* szErrMess, bool bDeleteMsg = true);
		Exception(const Exception&  exception);
		virtual ~Exception();

		const int errorCode() { return m_nErrorCode; }
		const char* errorMessage() { return m_pszErrorMsg; }
		static const char* errorCodeAsString(int nErrorCode);

	private:
		char* m_pszErrorMsg;
		int m_nErrorCode;
	};


	class Buffer
	{
	public:

		Buffer();
		~Buffer();

		const char* format(const char* szFormat, ...);
		operator const char*() { return m_pBuf; }

		void clear();

	private:

		char* m_pBuf;
	};


	class Binary
	{
	public:

		Binary();

		~Binary();

		void setBinary(const unsigned char* pBuf, int nLen);
		void setEncoded(const unsigned char* pBuf);

		const unsigned char* getEncoded();
		const unsigned char* getBinary();

		int getBinaryLength();

		unsigned char* allocBuffer(int nLen);

		void clear();

	private:

		unsigned char* m_pBuf;
		int m_nBinaryLen;
		int m_nBufferLen;
		int m_nEncodedLen;
		bool m_bEncoded;
	};


	class Query
	{
	public:

		Query();
		Query(sqlite3* pDB, sqlite3_stmt* pVM, bool bEof, bool bOwnStmt = true);
        
        Query(const Query& rQuery);
		Query& operator=(const Query& rQuery);

		virtual ~Query();

		int numFields();

		int fieldIndex(const char* szField);
		const char* fieldName(int nCol);

		const char* fieldDeclType(int nCol);
		int fieldDataType(int nCol);

		const char* fieldValue(int nField);
		const char* fieldValue(const char* szField);

		int getIntField(int nField, int nNullValue = 0);
		int getIntField(const char* szField, int nNullValue = 0);

		double getFloatField(int nField, double fNullValue = 0.0);
		double getFloatField(const char* szField, double fNullValue = 0.0);

		const char* getStringField(int nField, const char* szNullValue = "");
		const char* getStringField(const char* szField, const char* szNullValue = "");

		const unsigned char* getBlobField(int nField, int& nLen);
		const unsigned char* getBlobField(const char* szField, int& nLen);

		bool fieldIsNull(int nField);
		bool fieldIsNull(const char* szField);

		bool eof();

		void nextRow();

		void finalize();

	private:

		void checkStmt();

		sqlite3* m_pDatabase;
		sqlite3_stmt* m_pStatement;
		bool m_bEof;
		int m_nCols;
		bool m_bOwnStmt;
	};


	class Table
	{
	public:

		Table();
		Table(const Table& rTable);

		Table(char** paszResults, int nRows, int nCols);

		virtual ~Table();

		Table& operator=(const Table& rTable);

		int numFields();

		int numRows();

		const char* fieldName(int nCol);

		const char* fieldValue(int nField);
		const char* fieldValue(const char* szField);

		int getIntField(int nField, int nNullValue = 0);
		int getIntField(const char* szField, int nNullValue = 0);

		double getFloatField(int nField, double fNullValue = 0.0);
		double getFloatField(const char* szField, double fNullValue = 0.0);

		const char* getStringField(int nField, const char* szNullValue = "");
		const char* getStringField(const char* szField, const char* szNullValue = "");

		bool fieldIsNull(int nField);
		bool fieldIsNull(const char* szField);

		void setRow(int nRow);
		void finalize();

	private:

		void checkResults();

		int m_nCurrentRow;
		int m_nCols;
		int m_nRows;

		char** m_paszResults;
	};


	class Statement
	{
	public:

		Statement();
		Statement(const Statement& rStatement);

		Statement(sqlite3* pDB, sqlite3_stmt* pStmt);
		virtual ~Statement();

		Statement& operator=(const Statement& rStatement);

		int execDML();

		Query execQuery();

		void bind(int nParam, const char* szValue);
		void bind(int nParam, const int nValue);
		void bind(int nParam, const double dwValue);
		void bind(int nParam, const unsigned char* blobValue, int nLen);
		void bindNull(int nParam);

		void reset();

		void finalize();

	private:

        void checkStmt();
		void checkDB();

        sqlite3_stmt* m_pStatement;
		sqlite3* m_pDatabase;
	};


	class Database
	{
	public:

		Database();
		virtual ~Database();

		void Open(const char *szDBName);
		void Close();

		bool tableExists(const char* szTable);
		int execDML(const char* szSQL);

		Query execQuery(const char* szSQL);
		int execScalar(const char* szSQL);
		Table getTable(const char* szSQL);

		Statement compileStatement(const char* szSQL);
		sqlite_int64 lastRowId();

		void interrupt() { sqlite3_interrupt(m_pDatabase); }
		void setBusyTimeout(int nMillisecs);

		static const char* SQLiteVersion() { return SQLITE_VERSION; }

	private:
        
        // ...
		Database(const Database& db);
		Database& operator=(const Database& db);

		sqlite3_stmt* compile(const char* szSQL);

		void checkDB();
		sqlite3* m_pDatabase;
		int m_nBusyTimeoutMs;
	};
}
#endif	// SQLITE3CPP_H
