#!/bin/sh
tar -xf leveldb-1.23.tar.gz
cd leveldb-1.23
tar xf ../googletest-1.11.0.tar.gz -C third_party/googletest --strip-components=1
tar xf ../benchmark-1.8.0.tar.gz -C third_party/benchmark --strip-components=1
sed -i '4 a #include <ctime>' ./benchmarks/db_bench_sqlite3.cc
mkdir build
cd build
cmake  -DCMAKE_BUILD_TYPE=Release ..
cmake --build .
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd leveldb-1.23/build
./db_bench --threads=\$NUM_CPU_CORES \$@ > \$LOG_FILE
" > leveldb
chmod +x leveldb
