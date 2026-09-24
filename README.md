# Monad Red Envelope（电脑小白版）

## 最短流程
1. 安装 MetaMask 浏览器扩展。
2. 打开 Remix： https://remix.ethereum.org
3. 新建 `MonadRedEnvelope.sol`，复制同名文件里的合约代码。
4. 编译：左侧 Solidity 图标 → 选择 `0.8.20` → Compile。
5. 部署：左侧 Deploy 图标 → Environment 选 `Injected Provider - MetaMask` → 确认切换到 Monad Testnet → Deploy → 在钱包确认。
6. 复制部署后的合约地址。
7. 打开 `index.html`，搜索 `contractAddress`，把中文占位文字替换为合约地址。
8. 把整个文件夹上传 GitHub；在 GitHub Pages 开启网页。

## 重要
- 先使用测试网，不要放真实资产。
- GitHub Pages 只能托管网页，合约仍然在 Monad 链上。
- 需要让朋友领取时，把“红包编号”发给他们；他们打开网页、连接钱包、输入编号即可。
