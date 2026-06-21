# opencode Zeabur 部署

在 Zeabur 上部署 [opencode](https://opencode.ai) Web 服务，通过浏览器访问 AI 编码助手。

## 目录结构

```
├── Dockerfile       # 构建 opencode 镜像
├── entrypoint.sh    # 容器启动入口
├── opencode.json    # opencode 配置文件（API key 通过环境变量注入）
├── zbpack.json      # Zeabur 部署配置
└── .gitignore
```

## 部署步骤

### 1. 推送到 GitHub

创建 GitHub 仓库，将本目录所有文件推送上去。

### 2. 在 Zeabur 创建项目

- 打开 [Zeabur Dashboard](https://zeabur.com)
- 新建项目 → 选择该 GitHub 仓库
- Zeabur 会自动识别 Dockerfile 并构建部署

### 3. 设置环境变量

在 Zeabur 服务配置的 **Environment Variables** 中设置：

| 变量名 | 说明 | 必填 |
|--------|------|------|
| `ANTHROPIC_API_KEY` | Anthropic API key（使用 Claude 时需要） | 选填 |
| `OPENAI_API_KEY` | OpenAI API key（使用 GPT 时需要） | 选填 |
| `OPENCODE_SERVER_PASSWORD` | Web 登录密码 | **强烈建议** |
| `OPENCODE_SERVER_USERNAME` | Web 登录用户名，默认 `opencode` | 选填 |

> **提示：** 至少配置一个 LLM 提供商的 API Key，否则 opencode 无法工作。

### 4. 访问

部署完成后，访问 Zeabur 分配的域名即可在浏览器中使用 opencode。

## 本地测试

```bash
docker build -t opencode-zeabur .
docker run -p 8080:8080 \
  -e ANTHROPIC_API_KEY=sk-xxx \
  -e OPENCODE_SERVER_PASSWORD=your-password \
  opencode-zeabur
```

## 更新

推送到 GitHub 仓库后，Zeabur 会自动重新构建部署。
