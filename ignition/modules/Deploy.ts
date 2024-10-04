import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LudogameModule = buildModule("LudogameModule", (m) => {

  const LudoGame = m.contract("LudoGame");


  return { LudoGame };
});

export default LudogameModule;