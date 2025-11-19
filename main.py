import MySQLdb
import time

def main():
    print("Attempting to connect to MySQL...")
    
    # Retry logic in case DB is waking up
    for i in range(5):
        try:
            conn = MySQLdb.connect(
                host="127.0.0.1",
                user="root",
                passwd="mysecretpassword",
                db="testdb",
                port=3306,
            )
            print("[OK] Connected successfully!")

            cur = conn.cursor()
            cur.execute("SELECT VERSION()")
            print(f"[OK] Database Version: {cur.fetchone()[0]}")

            cur.close()
            conn.close()
            return
        except MySQLdb.OperationalError as e:
            print(f"[FAIL] Connection failed (attempt {i+1}/5): {e}")
            time.sleep(2)

    print("[FAIL] Could not connect.")

if __name__ == "__main__":
    main()
