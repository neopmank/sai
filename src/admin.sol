/// admin.sol -- admin manager

// Copyright (C) 2017  Nikolai Mushegian <nikolai@dapphub.com>
// Copyright (C) 2017  Daniel Brockman <daniel@dapphub.com>
// Copyright (C) 2017  Rain <rainbreak@riseup.net>

pragma solidity ^0.4.15;

import 'ds-thing/thing.sol';
import './tub.sol';
import './top.sol';
import './tap.sol';

contract SaiAdmin is DSThing {
    SaiTub  public  tub;
    SaiTap  public  tap;
    SaiVox  public  vox;

    function SaiAdmin(SaiTub tub_, SaiTap tap_, SaiVox vox_) {
        tub = tub_;
        tap = tap_;
        vox = vox_;
    }
    function mold(bytes32 param, uint val) note auth {
        tub.mold(param, val);
    }
    // Debt ceiling
    function setHat(uint wad) note auth {
        tub.mold("hat", wad);
    }
    // Liquidation ratio
    function setMat(uint ray) note auth {
        tub.mold("mat", ray);
        var axe = tub.axe();
        var mat = tub.mat();
        require(axe >= RAY && axe <= mat);
    }
    // Stability fee
    function setTax(uint ray) note auth {
        tub.mold("tax", ray);
        var tax = tub.tax();
        require(RAY <= tax);
        require(tax < 10002 * 10 ** 23);  // ~200% per hour
    }
    // Liquidation fee
    function setAxe(uint ray) note auth {
        tub.mold("axe", ray);
        var axe = tub.axe();
        var mat = tub.mat();
        require(axe >= RAY && axe <= mat);
    }
    // Join/Exit Spread
    function setTubGap(uint wad) note auth {
        tub.mold("gap", wad);
    }
    // Boom/Bust Spread
    function setTapGap(uint wad) note auth {
        tap.mold("gap", wad);
        var gap = tap.gap();
        require(gap <= 1.05 ether);
        require(gap >= 0.95 ether);
    }
    // Rate of change of target price (per second)
    function setWay(uint ray) note auth {
        require(ray < 10002 * 10 ** 23);  // ~200% per hour
        require(ray > 9998 * 10 ** 23);
        vox.mold("way", ray);
    }
}
