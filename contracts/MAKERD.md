<!-- @format -->

**ilk** - collateral type; each has its own set of risk parameters
<br/>
**urn** - vault; an ethereum address can control one urn per collateral type
<br/>
**gem** - unlocked collateral; gem is collateral that is not yet locked in a Vault but still recorded in the system
<br/>
**sin** - system debt unit; a debt balance that is tracked during liquidation process
<br/>
**dai** - stablecoin; a good debt token
<br/>
**Vat** - The single source of truth for the Maker Protocol. It contains the accounting system of
the core Vault, Internal Dai balances, and collateral state. The Vat has no external dependencies and maintains the central "Accounting Invariants" of the Maker Protocol. It houses the public interface for Vault management, allowing urn (Vault) owners to adjust their Vault state balances. It also contains the public interface for Vault fungibility, allowing urn (Vault) owners to transfer,
split, and merge Vaults. Excluding these interfaces, the Vat is accessed through trusted smartcontract modules.
<br/>
**Cat** - Public interface for confiscating unsafe urns (Vaults) and processing seized collateral
via their respective flip (collateral) auction. With large Vaults, partial confiscations of a fixed
collateral size will be processed until the urn becomes safe again.
<br/>
**Spotter** - Allows external actors to update the price feed in Vat for a given Ilk (collateral type).
**Join** - The Join adapter is used to deposit/withdraw unlocked collateral into the Vat.
Currently, GemJoin is only compatible with standard ERC20 tokens, but eventually there will be various types of Join adapters that are compatible with different Token Standards.
<br/>
**Flipper** - Collateral auction house. Each gem auction is unique and linked to a previously bitten urn (Vault). Investors bid with increasing amounts of DAI for a fixed GEM amount. When the DAI balance deficit is covered, bidders continue to bid for a
decreasing gem size until the auction is complete. Remaining GEM is returned to the Vault owner.
**DS-Token** - An implementation supporting the ERC20 Standard; part of the DappSys (DS) library.
Contains database of MKR owners, transfer and supply logic.
<br/>
**Vow** - The Vow represents the Maker Protocol’s balance, as the recipient of both system surplus and system debt. Its function is to cover deficits via debt auctions and discharge surpluses via surplus auctions.
<br/>
**Flopper** - Debt Auction house. Debt auctions are used to satisfy the Vow’s debt by auctioning off MKR for a fixed amount of internal Dai. Bidders compete with decreasing “amount requests” of MKR. After auction settlement, the Flopper sends the received internal Dai to the Vow to cancel out its debt. The Flopper mints the MKR for the winning bidder.
<br/>
**Flapper** - Surplus Auction house. Surplus auctions are used to liquidate the Vow’s surplus by auctioning off a fixed size of internal Dai for MKR. Bidders compete with increasing amounts
of MKR. After auction settlement, the Flapper burns the winning MKR bid and sends the internal Dai to the winning bidder.
<br/>
**Jug** - Contains drip(), a public function used to update an Ilk debt rate for an assigned stability fee. Since a debt rate is a function of time, it should be updated via drip() on a regular basis. Auction keepers, MKR holders, and other relevant stakeholders are incentivized to call Jug.drip().
<br/>
**Pot** - The Pot contract is where a Dai holder would lock up Internal Dai to accrue earned dai at the Dai Savings Rate. Similar to Jug, this contract employs its own Drip function used to update it’s own internal rate.This rate follows the Dai Savings Rate and is used in the exchange of a claim to the Pot’s Pie and Internal Dai. Dai holders, MKR holders, and other relevant stakeholders are incentivized to call Pot.drip(). A portion of the Stability Fee dividends is allocated for the Dai Savings Rate by increasing the amount of Sin in the Vow at eve_getWipeAllWadency Shutdown. It supports various scenarios, ranging from over-collateralization among all ilks to global under-
collateralization, which is when the net value of all collateral types is less than the total Dai supply. In the latter edge cases, where the collateral base is limited, the Vault owner payout (in the form of excess
collateral) is prioritized over the claims of Dai holders.
<br/>
**ESM** - The Emergency Shutdown Module (ESM) is a contract with the ability to call End.cage() and initiate ES. MKR holders join their funds, which are then immediately burnt. When the ESM's internal sum balance is equal to or greater than the minimum threshold, then End.cage() can be called.
**RO (Rates Oracle)** - Through admin access to the Rates Module, the Rates Oracle enables more dynamic updates to the Risk Premium Rates, Base Rate and Savings Rate. As a secondary governance mechanism, the Rates Oracle allows MKR holders to vote with the IOUs they receive when locking up their MKR in DS-Chief. Furthermore, to vote they have to stake some amount of Dai (e.g. $1000 or $10,000), which will be passed on to the Buffer if they vote for a losing proposal.
<br/>
**VO (NFT/LEIN Vault Oracle)** - Controlled by authorized Risk Team(s), the VO holds admin access to add an NFT/LIEN Vault type on the fly under certain restrictions.
<br/>
**Mom** - Mom is a contract interface to adjust the risk parameters of the Maker Protocol. The chief in DS-Chief has the exclusive authority to call functions through Mom. The following contracts rely on Mom: Spotter, Cat, Vow, Vat, and Jug.
**INT-RO (Rates Oracle Interface)** - Interface contract for the Rates Oracle. Accessible by the Rates Oracle. It has bounded authority over the Rates Module.
<br/>
**INT-VO (NFT/Lein Vault Oracle Interface)** - Interface contract for the NFT/LEIN Vault Oracle. It is authorized to add NFT/LEIN Vault types to the system.
<br/>
***Function daiJoin_join:*** it takes in two addresses and amount of Dai to be deposited. the apt address and the vault address.
the Dai is been transfered from the sender address to the contract address. the adapter is been approved to spend the Dai, then the Dai joins the vault.
<br/>
***Function transfer:*** this function takes in two addresses and amount. the gem address which is the address of the collateral that is not locked in the vault yet, and the standard ERC20 address. the Amt is been transfered to the the standard ERC20 address.
<br/>
***Function ethJoin_join:*** it takes in wo addresses, the adapter address and the vault address.
<br/>
***GemJoinLike(apt).gem().deposit.value(msg.value)():*** This function takes the ether value to be converted to WETH, then the contract is beeen approve to spend the ether, the approved ether is added to the vault.
<br/>
***Function gemJoin_join(address apt, address urn, uint amt, bool transferFrom):*** this takes in two addresses, an amount and a boolean. if the amount has been approved then this function joins the vault else it approves first then join the vault.
***Function open:*** Takes in two addresses and the bytes of the collateral type. the addresses are the user address and the manager's address. the managerlike is to formalise vault transfer enabling vault to be treated like asset. it creates the urnHandler
<br/>
***Function give:*** takes in two addresses and the uint of the cdp.it transfers the ownership of cdp to usr address in the manager registry
<br/>
***Function giveToProxy:*** takes in 3 addresses and the uint of the cdp.
the address proxyRegistry is the contract proxy address of the user. It transfers the ownership of cdp to the proxy of usr address (via proxyRegistry) in the manager registry. it get the actual proxy address and check if the proxy address already exist and make sure the dst address is still the real owner and check is been carried out to know if it is the dst dst address is an EOA or a contract address, then a proxy is been created for dst address.
<br/>
***Function cdpAllow ( address manager, uint cdp, address usr, uint ok):*** Allows/denies usr address to manage the cdp
<br/>
***Function urnAllow:*** allows/denies usr address to manage the msg.sender address as dst for quit
***Function flux:*** moves wad amount of collateral from cdp address to dst address.
<br/>
***Function move:*** moves rad amount of DAI from cdp address to dst address
<br/>
***Function frob:*** executes frob to cdp address assigning the collateral freed and/or DAI drawn to the same address.
<br/>
***Function quit:*** moves cdp collateral balance and debt to dst address
<br/>
***Function enter:*** moves src collateral balance and debt to cdp
<br/>
***Function shift:*** moves cdpSrc collateral balance and debt to cdpDst
<br/>
***Function makeGemBag:*** it takes in the addresss of the gem i.e the gem that is not yet locked and an address is been returned to enable the deposit of the gem.
<br/>
***Function lockETH(address manager, address ethJoin, uint cdp):*** it receives the Eth and convert it to WETH. the deposits msg.value amount of ETH in ethJoin adapter and executes frob to cdp increasing the locked value.
v
***Function safeLockETH(address manager, address ethJoin, uint cdp address owner):*** sameas lockETH but requiring owner == cdp owner
<br/>
***Function lockGem(address manager,address gemJoin, uint cdp, uint amt, bool transferFrom):*** it takes the token amount from users wallet i.e the gem to locked, and is been locked in gemJoin adapter and executes frob to cdp increasing the locked value. Gets funds from msg.sender if transferFrom == true
<br/>
***Function safeLockGem( address manager, address gemJoin, uint cdp, uint amt, bool transferFrom, address owner):*** same as lockGem but requiring owner == cdp owner.
<br/>
***Function freeETH( address manager, address ethJoin, uint cdp, uint wad):*** unlocks the WETH, executes frob to cdp decreasing locked collateral and withdraws wad amount of ETH from ethJoin adapter.
<br/>
***Function freeGem(address manager,address gemJoin, uint cdp, uint amt):*** unlocks token amount i.e the unfree gem form the cdp, moves the amount to the proxy address and withdraws wad amount of collateral from gemjoin adapter to the user wallet.
<br/>
***Function exitETH( address manager,address ethJoin, uint cdp,uint wad):*** moves wad amount of ETH from ethJoin adapter and covert the WETH to ETH sends ETH back to the users wallet.
<br/>
***Function exitGem( address manager, address gemJoin, uint cdp, uint amt):*** moves the amount to the proxy address and send token to the users wallet i.e the gem that is free at this instance.
<br/>
***Function draw( address manager, address jug, address daiJoin, uint cdp, uint wad ):*** updates collateral fee rate, executes frob to cdp increasing debt and exits wad amount of DAI token (mintiafter system is caged, recovers remaining ETH from cdp (pays remaining debt if exists) from daiJoin adapter.
<br/>
***Function wipe( address manager, address daiJoin, uint cdp, uint wad):*** joins wad amount of DAI token to daiJoin adapter (burning it) and executes frob to cdp for decreasing debt.i.e paying back debt.
<br/>
***Function safeWipe( address manager,address daiJoin, uint cdp, uint wad, address owner ):*** same as wipe but requiring owner == cdp owner
<br/>
***Function wipeAll(address manager, address daiJoin, uint cdp):*** joins all the necessary amount of DAI token to daiJoin adapter (burning it) and executes frob to cdp setting the debt to zero.
<br/>
***Function safeWipeAll( address manager, address daiJoin, uint cdp, address owner):*** same as wipeAll but requiring owner == cdp owner.
<br/>
***Function lockETHAndDraw( address manager, address jug, address ethJoin, address daiJoin, uint cdp, uint wadD ):*** combines lockETH and draw.
<br/>
***Function openLockETHAndDraw( address manager, address jug, address ethJoin, address daiJoin, bytes32 ilk, uint wadD):*** combines open, lockETHAndDraw.
<br/>
***Function lockGemAndDraw( address manager, address jug, address gemJoin, address daiJoin, uint cdp, uint amtC, uint wadD, bool transferFrom):*** takes token Amount from the wallet and joins to the vat, locks the token amount into cdp and generates the debt, moves the balance to the proxys address, the adapter is allowed to access the proxy's Dai balance in the vat if dai balance is  == 0 it goes to the hope function else the dai is sent to the user wallet.
<br/>
***Function openLockGemAndDraw( address manager, address jug, address gemJoin, address daiJoin, bytes32 ilk, uint amtC, uint wadD, bool transferFrom):*** combines open, lockGemAndDraw.
<br/>
***Function openLockGNTAndDraw( address manager, address jug, address gntJoin, address daiJoin, bytes32 ilk, uint amtC, uint wadD ):*** like openLockGemAndDraw but specially for GNT token.
<br/>
***Function wipeAndFreeETH( address manager, address ethJoin, address daiJoin,uint cdp, uint wadC, uint wadD):*** combines wipe and freeETH. Joins Dai amount into the vat payback debt to cdp and unlockes WETH from it and send it to the usr wallet address
<br/>
***Function wipeAllAndFreeETH( address manager, address ethJoin, address daiJoin, uint cdp, uint wadC):*** same as wipeAndFreeETH.
<br/>
***Function wipeAndFreeGem( address manager, address gemJoin, address daiJoin, uint cdp, uint amtC, uint wadD):*** same as wipeAndFreeETH but token is used in this case.
<br/>
***Function wipeAllAndFreeGem( address manager, address gemJoin, address daiJoin, uint cdp, uint amtC):*** same as wipeAndFreeGem
<br/>
***Function _free( address manager, address end, uint cdp):*** it takes in two address and the uint of cdp. if debt still occur, it get paid first. position is been transferred to the proxy's address, the position is been freed and collateral is been recovered.
<br/>
***Function freeETH(address manager, address ethJoin, address end, uint cdp):*** ater system is caged, recovers remaining ETH from cdp (pays remaining debt if exists).
<br/>
***Function freeGem( address manager, address gemJoin, address end, uint cdp):*** after system is caged, recovers remaining token from cdp (pays remaining debt if exists).
<br/>
***Function pack( address daiJoin, address end, uint wad):*** after system is caged, packs wad amount of DAI to be ready for cashing.
<br/>
***Function cashETH( address ethJoin, address end, bytes32 ilk, uint wad):*** after system is caged, cashes wad amount of previously packed DAI and returns the equivalent in ETH.
<br/>
***Function cashGem( address gemJoin, address end, bytes32 ilk, uint wad):*** after system is caged, cashes wad amount of previously packed DAI and returns the equivalent in token.
<br/>
***Function join( address daiJoin, address pot, uint wad ):*** joins wad amount of DAI token to daiJoin adapter (burning it) and moves balance to pot for DAI Saving Rates.
<br/>
***Function exit( address daiJoin, address pot, uint wad):*** retrieves wad amount of DAI from pot and exits DAI token from daiJoin adapter (minting it).
<br/>
***Function exitAll( address daiJoin, address pot):*** same as exit but all the available amount.
