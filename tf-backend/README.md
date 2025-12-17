Entra nella VM PostgreSQL
ssh rocky@172.18.41.113

2️⃣ Apri pg_hba.conf

Su Rocky Linux:

sudo vi /var/lib/pgsql/data/pg_hba.conf

3️⃣ Aggiungi ESATTAMENTE questa riga (in fondo):
host    tf_state    tf_user    172.18.41.120/32    md5

host    all         all        172.18.41.120/32    md5

4️⃣ Riavvia PostgreSQL
sudo systemctl restart postgresql

5️⃣ Riprova dal controller
terraform init \
  -reconfigure \
  -backend-config="conn_str=postgres://tf_user:tf_password@172.18.41.113:5432/tf_state?sslmode=disable"
