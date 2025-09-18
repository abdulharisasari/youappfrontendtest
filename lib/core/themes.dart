import 'package:flutter/material.dart';

const int primaryLightColor = 0xFF1F4247;
const int primaryColor = 0xFF0D1D23;
const int primaryDarkColor = 0xFF09141A;

const int goldDarkColor1 = 0xFF94783E;
const int goldDarkColor2 = 0xFFF3EDA6;
const int goldDarkColor3 = 0xFFF8FAE5;
const int goldDarkColor4 = 0xFFFFE2BE;
const int goldColor = 0xFFD5BE88;

const int cardLightColor = 0xFF162329;
const int cardDarkColor = 0xFF0E191F;

const int textfieldAboutColor = 0xD9D9D90F;

const int buttonDarkColor = 0xFF4599DB;
const int buttonLightColor =0xFF62CDCB;

const int bgInterestCard = 0x0FD9D9D9;

const LinearGradient goldGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [ Color(goldDarkColor1), Color(goldDarkColor2), Color(goldDarkColor3), Color(goldDarkColor4), Color(goldColor), Color(goldDarkColor3), Color(goldColor)],
  stops: [ 0.0, 0.1676, 0.305, 0.496, 0.7856, 0.8901, 1.0, ],
);

const LinearGradient blueGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFABFFFD),
    Color(0xFF4599DB),
    Color(0xFFAADAFF),
  ],
  stops: [
    0.0264, 
    1.024,  
    1.0,    
  ],
);

