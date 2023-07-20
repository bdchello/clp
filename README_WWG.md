## 目录
```
├── components
│   ├── clp-py-utils
│   ├── compression-job-handler
│   ├── core
│   │   ├── CHANGELOG.md
│   │   ├── cmake
│   │   │   ├── Modules
│   │   │   │   ├── FindLibArchive.cmake
│   │   │   │   ├── FindLibraryDependencies.cmake
│   │   │   │   ├── FindLZ4.cmake
│   │   │   │   ├── FindMariaDBClient.cmake
│   │   │   │   ├── FindOpenSSL.cmake
│   │   │   │   ├── FindZStd.cmake
│   │   │   │   └── LibFindMacros.cmake
│   │   │   └── utils.cmake
│   │   ├── CMakeLists.txt
│   │   ├── config
│   │   │   ├── metadata-db.yml
│   │   │   └── schemas.txt
│   │   ├── information.txt
│   │   ├── logs                                                                            # 测试数据
│   │   ├── README.md
│   │   ├── README-Schema.md
│   │   ├── src
│   │   ├── submodules                                                          # 依赖子模块的源码（动态下载）
│   │   │   ├── Catch2
│   │   │   ├── date
│   │   │   ├── json
│   │   │   ├── sqlite3
│   │   │   └── yaml-cpp                                                
│   │   ├── tests                                                                           # 单元测试
│   │   └── tools
│   │       ├── docker-images
│   │       │   ├── clp-core-focal
│   │       │   │   └── Dockerfile
│   │       │   ├── clp-env-base-bionic
│   │       │   │   ├── build.sh
│   │       │   │   └── Dockerfile
│   │       │   ├── clp-env-base-centos7.4
│   │       │   │   ├── build.sh
│   │       │   │   ├── Dockerfile
│   │       │   │   └── setup-scripts
│   │       │   │       └── git
│   │       │   └── clp-env-base-focal
│   │       │       ├── build.sh
│   │       │       └── Dockerfile
│   │       └── scripts
│   │           ├── db
│   │           │   └── init-db.py
│   │           ├── deps-download 
│   │           │   ├── Catch2.json
│   │           │   ├── date.json
│   │           │   ├── download-all.sh                                         # 根据json配置文件下载依赖的子模块
│   │           │   ├── download-dep.py
│   │           │   ├── json.json
│   │           │   ├── sqlite3.json
│   │           │   └── yaml-cpp.json
│   │           ├── lib_install
│   │           │   ├── centos7.4
│   │           │   │   ├── install-all.sh
│   │           │   │   ├── install-packages-from-source.sh
│   │           │   │   ├── install-prebuilt-packages.sh
│   │           │   │   └── README.md
│   │           │   ├── fmtlib.sh
│   │           │   ├── install-boost.sh
│   │           │   ├── install-cmake.sh
│   │           │   ├── libarchive.sh
│   │           │   ├── lz4.sh
│   │           │   ├── macos-12
│   │           │   │   ├── install-all.sh
│   │           │   │   └── README.md
│   │           │   ├── mariadb-connector-c.sh
│   │           │   ├── msgpack.sh
│   │           │   ├── spdlog.sh
│   │           │   ├── ubuntu-bionic
│   │           │   │   ├── install-all.sh
│   │           │   │   ├── install-packages-from-source.sh
│   │           │   │   ├── install-prebuilt-packages.sh
│   │           │   │   └── README.md
│   │           │   ├── ubuntu-focal
│   │           │   │   ├── install-all.sh
│   │           │   │   ├── install-packages-from-source.sh
│   │           │   │   ├── install-prebuilt-packages.sh
│   │           │   │   └── README.md
│   │           │   └── zstandard.sh
│   │           └── utils
│   │               ├── README.md
│   │               └── run-in-container.sh
│   ├── job-orchestration
│   └── package-template
│       ├── README.md
│       └── src
│           ├── etc
│           │   ├── clp-config.yml
│           │   ├── clp-schema.template.txt
│           │   ├── credentials.template.yml
│           │   └── mysql
│           │       └── conf.d
│           │           └── logging.cnf
│           ├── lib
│           │   └── python3
│           │       └── site-packages
│           │           └── clp
│           │               └── package_utils.py
│           ├── LICENSE
│           ├── README.md
│           ├── requirements-pre-3.7.txt
│           └── sbin
│               ├── compress
│               ├── decompress
│               ├── native
│               │   ├── compress
│               │   ├── decompress
│               │   └── search
│               ├── search
│               ├── start-clp
│               └── stop-clp
├── config
│   └── build-clp-package.yaml                                                     # 构建编译环境配置文件（由build-clp-package.py触发）
├── docs
│   └── Datasets.md                                                                            # 测试数据集地址
├── LICENSE
├── README.md
├── README_WWG.md
└── tools
    ├── docker-images
    │   └── clp-execution-base-focal
    │       ├── build.sh
    │       ├── Dockerfile
    │       └── setup-scripts
    │           ├── install-packages-from-source.sh
    │           └── install-prebuilt-packages.sh
    └── packager
        ├── build-clp-package.py
        ├── install-scripts
        │   ├── install-core.sh                                                                 # 编译clp、clg、clo
        │   └── install-python-component.sh                                 # 
        ├── README.md
        ├── requirements-pre-3.7.txt
        └── requirements.txt

232 directories, 2205 files
```
## 编译
```
docker run --rm -it \
  --name 'clp-build-env' \
  -uroot \
  -v$(readlink -f /mnt/data/wangwengang/clp/components/core):/mnt/clp \
  -v$(readlink -f /mnt/data/wangwengang/clp/logs):/mnt/logs \
  ghcr.io/y-scope/clp/clp-core-dependencies-x86-ubuntu-focal:main \
  /bin/bash

cd /mnt/clp

./tools/scripts/deps-download/download-all.sh
```

### # linux_x86
> ./tools/scripts/lib_install/ubuntu-focal/install-all.sh
> ./tools/scripts/build_linux_x86.sh 

### # android_armv8
>./tools/scripts/build_android_armv8.sh

### # linux_aarch64
> TODO