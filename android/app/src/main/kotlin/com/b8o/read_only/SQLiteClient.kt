package com.b8o.read_only

import io.flutter.Log
import android.database.sqlite.SQLiteException
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper

class SqliteClient(context: Context, name: String, version: Int, initSqlList: List<String>) {

    private val dbHelper: DatabaseHelper = DatabaseHelper(context, name, version, initSqlList)

    fun openDatabase(): SQLiteDatabase {
        return dbHelper.writableDatabase
    }

    fun closeDatabase() {
        dbHelper.close()
    }

    fun insert(tableName: String, columns: List<String>, values: List<String>): Int {
        val db = openDatabase()
        val idColumn = "id" // assuming ID column is named "id"
        val idValue = values[columns.indexOf(idColumn)] // assuming ID value is provided in the values list
        val selectQuery = "SELECT COUNT(*) FROM $tableName WHERE $idColumn = '$idValue'"
        val cursor = db.rawQuery(selectQuery, null)
        cursor.moveToFirst()
        val count = cursor.getInt(0)
        cursor.close()
        if (count == 0) {
            val columnsString = columns.joinToString(", ")
            val valuesString = values.joinToString(", ") { "'$it'" }
            val insertQuery = "INSERT INTO $tableName ($columnsString) VALUES ($valuesString)"
            db.execSQL(insertQuery)
            closeDatabase()
            return 1 // 1 row inserted
        } else {
            closeDatabase()
            return 0 // 0 row inserted
        }
    }

    fun select(tableName: String, whereStatement: String? = null, columns: List<String>): List<Map<String, String>> {
        val db = openDatabase()

        val columnsString = columns.joinToString(", ")

        val query = "SELECT $columnsString FROM $tableName" + (whereStatement?.let { " WHERE $it" } ?: "")

        val cursor = db.rawQuery(query, null)

        val rows = mutableListOf<Map<String, String>>()

        while (cursor.moveToNext()) {
            val row = mutableMapOf<String, String>()
            columns.forEachIndexed { i, column ->
                row[column] = cursor.getString(i)
            }
            rows.add(row)
        }

        cursor.close()
        closeDatabase()

        return rows
    }

    fun update(tableName: String, whereStatement: String, columnName: String, columnValue: String) {
        val db = openDatabase()

        val updateQuery = "UPDATE $tableName SET $columnName='$columnValue' WHERE $whereStatement"

        db.execSQL(updateQuery)

        closeDatabase()
    }

    fun delete(tableName: String, whereStatement: String) {
        val db = openDatabase()

        val deleteQuery = "DELETE FROM $tableName WHERE $whereStatement"

        db.execSQL(deleteQuery)

        closeDatabase()
    }
    
    private class DatabaseHelper(context: Context, name: String, version: Int, initSqlList: List<String>) :
        SQLiteOpenHelper(context, name, null, version) {

        private val initSqlList: List<String> = initSqlList

        override fun onCreate(db: SQLiteDatabase) {
            initSqlList.forEach { sql ->
                db.execSQL(sql)
            }
        }

        override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
            // handle database upgrade here
        }
    }
}
