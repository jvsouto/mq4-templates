// Base EA template
// More templates and snippets on https://github.com/sibvic/mq4-templates

#property version   "1.0"
#property description "Developed by Victor Tereschenko: sibvic@gmail.com"
#property strict

#define SHOW_ACCOUNT_STAT
#ifdef SHOW_ACCOUNT_STAT
string EA_NAME = "[EA NAME]";
#endif

#define REVERSABLE_LOGIC_FEATURE input

#define STOP_LOSS_FEATURE input
#define USE_ATR_TRAILLING
#define NET_STOP_LOSS_FEATURE input
#define USE_NET_BREAKEVEN

#define TAKE_PROFIT_FEATURE input
#define NET_TAKE_PROFIT_FEATURE input

#define MARTINGALE_FEATURE input
#define USE_MARKET_ORDERS

#define WEEKLY_TRADING_TIME_FEATURE input
#define TRADING_TIME_FEATURE input

#define POSITION_CAP_FEATURE input

#define CUSTOM_EXIT_FEATURE

enum TradingMode
{
   TradingModeLive, // Live
   TradingModeOnBarClose // On bar close
};

input string GeneralSection = ""; // == General ==
input TradingMode trade_live = TradingModeLive; // Trade live?
enum PositionSizeType
{
   PositionSizeAmount, // $
   PositionSizeContract, // In contracts
   PositionSizeEquity, // % of equity
   PositionSizeRisk // Risk in % of equity
};
enum LogicDirection
{
   DirectLogic, // Direct
   ReversalLogic // Reversal
};
enum TradingSide
{
   LongSideOnly, // Long
   ShortSideOnly, // Short
   BothSides // Both
};
input double lots_value = 0.1; // Position size
input PositionSizeType lots_type = PositionSizeContract; // Position size type
input int slippage_points = 3; // Slippage, points
input TradingSide trading_side = BothSides; // What trades should be taken
REVERSABLE_LOGIC_FEATURE LogicDirection logic_direction = DirectLogic; // Logic type
#ifdef USE_MARKET_ORDERS
   input bool close_on_opposite = true; // Close on opposite signal
#else
   bool close_on_opposite = false;
#endif

POSITION_CAP_FEATURE string CapSection = ""; // == Position cap ==
POSITION_CAP_FEATURE bool position_cap = false; // Position Cap
POSITION_CAP_FEATURE int no_of_positions = 1; // Max # of buy+sell positions
POSITION_CAP_FEATURE int no_of_buy_position = 1; // Max # of buy positions
POSITION_CAP_FEATURE int no_of_sell_position = 1; // Max # of sell positions

#ifdef MARTINGALE_FEATURE
input string MartingaleSection = ""; // == Martingale type ==
enum MartingaleType
{
   MartingaleDoNotUse, // Do not use
   MartingaleOnLoss // Open another position on loss
};
enum MartingaleLotSizingType
{
   MartingaleLotSizingNo, // No lot sizing
   MartingaleLotSizingMultiplicator, // Using miltiplicator
   MartingaleLotSizingAdd // Addition
};
enum MartingaleStepSizeType
{
   MartingaleStepSizePips, // Pips
   MartingaleStepSizePercent, // %
};
input MartingaleType martingale_type = MartingaleDoNotUse; // Martingale type
input MartingaleLotSizingType martingale_lot_sizing_type = MartingaleLotSizingNo; // Martingale lot sizing type
input double martingale_lot_value = 1.5; // Matringale lot sizing value
input MartingaleStepSizeType martingale_step_type = MartingaleStepSizePercent; // Step unit
input double martingale_step = 5; // Open matringale position step
#endif

STOP_LOSS_FEATURE string StopLossSection            = ""; // == Stop loss ==
enum TrailingType
{
   TrailingDontUse, // No trailing
   TrailingPips, // Use trailing in pips
   TrailingPercent // Use trailing in % of stop
#ifdef USE_ATR_TRAILLING
   ,TrailingATR // Use ATR trailing
#endif
};
enum StopLimitType
{
   StopLimitDoNotUse, // Do not use
   StopLimitPercent, // Set in %
   StopLimitPips, // Set in Pips
   StopLimitDollar, // Set in $,
   StopLimitRiskReward, // Set in % of stop loss
   StopLimitAbsolute // Set in absolite value (rate)
};
STOP_LOSS_FEATURE StopLimitType stop_loss_type = StopLimitDoNotUse; // Stop loss type
STOP_LOSS_FEATURE double stop_loss_value            = 10; // Stop loss value
STOP_LOSS_FEATURE TrailingType trailing_type = TrailingDontUse; // Trailing type
STOP_LOSS_FEATURE double trailing_step = 10; // Trailing step
STOP_LOSS_FEATURE double trailing_start = 0; // Min distance to order to activate the trailing
#ifdef USE_ATR_TRAILLING
   STOP_LOSS_FEATURE double atr_trailing_multiplier = 0.1; // Multiplier for ATR trailing
#endif
STOP_LOSS_FEATURE StopLimitType breakeven_type = StopLimitDoNotUse; // Trigger type for the breakeven
STOP_LOSS_FEATURE double breakeven_value = 10; // Trigger for the breakeven
STOP_LOSS_FEATURE double breakeven_level = 0; // Breakeven target
#ifdef NET_STOP_LOSS_FEATURE
input StopLimitType net_stop_loss_type = StopLimitDoNotUse; // Net stop loss type
input double net_stop_loss_value = 10; // Net stop loss value
#endif

TAKE_PROFIT_FEATURE string TakeProfitSection            = ""; // == Take Profit ==
TAKE_PROFIT_FEATURE StopLimitType take_profit_type = StopLimitDoNotUse; // Take profit type
TAKE_PROFIT_FEATURE double take_profit_value           = 10; // Take profit value
#ifdef NET_TAKE_PROFIT_FEATURE
input StopLimitType net_take_profit_type = StopLimitDoNotUse; // Net take profit type
input double net_take_profit_value = 10; // Net take profit value
#endif

#ifndef DayOfWeek_IMP
enum DayOfWeek
{
   DayOfWeekSunday = 0, // Sunday
   DayOfWeekMonday = 1, // Monday
   DayOfWeekTuesday = 2, // Tuesday
   DayOfWeekWednesday = 3, // Wednesday
   DayOfWeekThursday = 4, // Thursday
   DayOfWeekFriday = 5, // Friday
   DayOfWeekSaturday = 6 // Saturday
};
#define DayOfWeek_IMP
#endif

TRADING_TIME_FEATURE string OtherSection            = ""; // == Other ==
TRADING_TIME_FEATURE int magic_number        = 42; // Magic number
TRADING_TIME_FEATURE string start_time = "000000"; // Start time in hhmmss format
TRADING_TIME_FEATURE string stop_time = "000000"; // Stop time in hhmmss format
WEEKLY_TRADING_TIME_FEATURE bool use_weekly_timing = false; // Weekly time
WEEKLY_TRADING_TIME_FEATURE DayOfWeek week_start_day = DayOfWeekSunday; // Start day
WEEKLY_TRADING_TIME_FEATURE string week_start_time = "000000"; // Start time in hhmmss format
WEEKLY_TRADING_TIME_FEATURE DayOfWeek week_stop_day = DayOfWeekSaturday; // Stop day
WEEKLY_TRADING_TIME_FEATURE string week_stop_time = "235959"; // Stop time in hhmmss format
WEEKLY_TRADING_TIME_FEATURE bool mandatory_closing = false; // Mandatory closing for non-trading time

bool ecn_broker = false;

#include <Signaler.mq4>
#include <InstrumentInfo.mq4>
#include <conditions/ICondition.mq4>
#include <conditions/ABaseCondition.mq4>
#include <condition.mq4>
#ifdef CUSTOM_EXIT_FEATURE
#include <CustomExitLogic.mq4>
#endif
#ifndef USE_MARKET_ORDERS
#include <Streams/AStream.mq4>
class LongEntryStream : public AStream
{
public:
   LongEntryStream(const string symbol, const ENUM_TIMEFRAMES timeframe)
      :AStream(symbol, timeframe)
   {
   }

   bool GetValue(const int period, double &val)
   {
      val = iHigh(_symbol, _timeframe, period);
      return true;
   }
};

class ShortEntryStream : public AStream
{
public:
   ShortEntryStream(const string symbol, const ENUM_TIMEFRAMES timeframe)
      :AStream(symbol, timeframe)
   {
   }

   bool GetValue(const int period, double &val)
   {
      val = iHigh(_symbol, _timeframe, period);
      return true;
   }
};
#endif

enum OrderSide
{
   BuySide,
   SellSide
};

#include <OrdersIterator.mq4>
#include <TradingCalculator.mq4>
#include <Order.mq4>
#include <Actions/IAction.mq4>
#include <Actions/AAction.mq4>
#include <Actions/MoveToBreakevenAction.mq4>
#include <Logic/ActionOnConditionController.mq4>
#include <Logic/ActionOnConditionLogic.mq4>
#include <Conditions/HitProfitCondition.mq4>
#include <breakeven.mq4>
#include <TrailingController.mq4>
#ifdef NET_STOP_LOSS_FEATURE
#include <Actions/MoveNetStopLossAction.mq4>
#endif
#ifdef NET_TAKE_PROFIT_FEATURE
#include <Actions/MoveNetTakeProfitAction.mq4>
#endif
#include <TradingTime.mq4>
#include <MoneyManagement.mq4>
#ifdef MARTINGALE_FEATURE
#include <MartingaleStrategy.mq4>
#endif
#include <TradingCommands.mq4>
#include <CloseOnOpposite.mq4>
#ifdef POSITION_CAP_FEATURE
#include <PositionCap.mq4>
#endif
#include <OrderBuilder.mq4>
#include <MarketOrderBuilder.mq4>
#include <EntryStrategy.mq4>
#include <MandatoryClosing.mq4>
#include <TradingController.mq4>
#include <Conditions/NoCondition.mq4>

TradingController *controllers[];
#ifdef SHOW_ACCOUNT_STAT
AccountStatistics *stats;
#endif

ICondition* CreateLongCondition(string symbol, ENUM_TIMEFRAMES timeframe)
{
   if (trading_side == ShortSideOnly)
      return (ICondition *)new DisabledCondition();

   return (ICondition *)new LongCondition(symbol, timeframe);
}

ICondition* CreateShortCondition(string symbol, ENUM_TIMEFRAMES timeframe)
{
   if (trading_side == ShortSideOnly)
      return (ICondition *)new DisabledCondition();

   return (ICondition *)new ShortCondition(symbol, timeframe);
}

ICondition* CreateExitLongCondition(string symbol, ENUM_TIMEFRAMES timeframe)
{
   return new ExitLongCondition(symbol, timeframe);
}

ICondition* CreateExitShortCondition(string symbol, ENUM_TIMEFRAMES timeframe)
{
   return new ExitShortCondition(symbol, timeframe);
}

TradingController *CreateController(const string symbol, const ENUM_TIMEFRAMES timeframe, string &error)
{
   TradingTime *tradingTime = new TradingTime();
   if (!tradingTime.Init(start_time, stop_time, error))
   {
      delete tradingTime;
      return NULL;
   }
   if (use_weekly_timing && !tradingTime.SetWeekTradingTime(week_start_day, week_start_time, week_stop_day, week_stop_time, error))
   {
      delete tradingTime;
      return NULL;
   }

   TradingCalculator *tradingCalculator = TradingCalculator::Create(symbol);
   if (!tradingCalculator.IsLotsValid(lots_value, lots_type, error))
   {
      delete tradingCalculator;
      delete tradingTime;
      return NULL;
   }
   Signaler *signaler = new Signaler(symbol, timeframe);
   signaler.SetMessagePrefix(symbol + "/" + signaler.GetTimeframeStr() + ": ");
   ActionOnConditionLogic* actions = new ActionOnConditionLogic();
   TradingController *controller = new TradingController(tradingCalculator, timeframe, signaler);
   controller.SetActions(actions);
   if (breakeven_type == StopLimitDoNotUse)
      controller.SetBreakeven(new DisabledBreakevenLogic());
   else
      #ifdef USE_NET_BREAKEVEN
         controller.SetBreakeven(new NetBreakevenLogic(tradingCalculator, breakeven_type, breakeven_value, breakeven_level, signaler));
      #else
         controller.SetBreakeven(new BreakevenLogic(breakeven_type, breakeven_value, breakeven_level, signaler, actions));
      #endif

   if (trailing_type == TrailingDontUse)
      controller.SetTrailing(new DisabledTrailingLogic());
   else
      #ifdef USE_ATR_TRAILLING
         controller.SetTrailing(new TrailingLogic(trailing_type, trailing_step, atr_trailing_multiplier, 0, timeframe, signaler));
      #else
         controller.SetTrailing(new TrailingLogic(trailing_type, trailing_step, 0, trailing_start, timeframe, signaler));
      #endif

   controller.SetTradingTime(tradingTime);
#ifdef MARTINGALE_FEATURE
   switch (martingale_type)
   {
      case MartingaleDoNotUse:
         controller.SetShortMartingaleStrategy(new NoMartingaleStrategy());
         controller.SetLongMartingaleStrategy(new NoMartingaleStrategy());
         break;
      case MartingaleOnLoss:
         controller.SetShortMartingaleStrategy(new ActiveMartingaleStrategy(tradingCalculator, martingale_lot_sizing_type, martingale_step_type, martingale_step, martingale_lot_value));
         controller.SetLongMartingaleStrategy(new ActiveMartingaleStrategy(tradingCalculator, martingale_lot_sizing_type, martingale_step_type, martingale_step, martingale_lot_value));
         break;
   }
#endif

   ICondition *longCondition = CreateLongCondition(symbol, timeframe);
   ICondition *shortCondition = CreateShortCondition(symbol, timeframe);
   IMoneyManagementStrategy *longMoneyManagement = new LongMoneyManagementStrategy(tradingCalculator, lots_type, lots_value, stop_loss_type, stop_loss_value, take_profit_type, take_profit_value);
   IMoneyManagementStrategy *shortMoneyManagement = new ShortMoneyManagementStrategy(tradingCalculator, lots_type, lots_value, stop_loss_type, stop_loss_value, take_profit_type, take_profit_value);
   ICondition *exitLongCondition = CreateExitLongCondition(symbol, timeframe);
   ICondition *exitShortCondition = CreateExitShortCondition(symbol, timeframe);
   switch (logic_direction)
   {
      case DirectLogic:
         controller.SetLongCondition(longCondition);
         controller.SetShortCondition(shortCondition);
         controller.SetExitLongCondition(exitLongCondition);
         controller.SetExitShortCondition(exitShortCondition);
         break;
      case ReversalLogic:
         controller.SetLongCondition(shortCondition);
         controller.SetShortCondition(longCondition);
         controller.SetExitLongCondition(exitShortCondition);
         controller.SetExitShortCondition(exitLongCondition);
         break;
   }
   controller.AddLongMoneyManagement(longMoneyManagement);
   controller.AddShortMoneyManagement(shortMoneyManagement);

   controller.SetExitAllCondition(new DisabledCondition());
#ifdef NET_STOP_LOSS_FEATURE
   if (net_stop_loss_type != StopLimitDoNotUse)
   {
      IAction* action = new MoveNetStopLossAction(tradingCalculator, net_stop_loss_type, net_stop_loss_value, signaler, magic_number);
      actions.AddActionOnCondition(action, new NoCondition());
      action.Release();
   }
#endif
#ifdef NET_TAKE_PROFIT_FEATURE
   if (net_take_profit_type != StopLimitDoNotUse)
   {
      IAction* action = new MoveNetTakeProfitAction(tradingCalculator, net_take_profit_type, net_take_profit_value, signaler, magic_number);
      actions.AddActionOnCondition(action, new NoCondition());
      action.Release();
   }
#endif

   if (close_on_opposite)
      controller.SetCloseOnOpposite(new DoCloseOnOppositeStrategy(slippage_points, magic_number));
   else
      controller.SetCloseOnOpposite(new DontCloseOnOppositeStrategy());

#ifdef POSITION_CAP_FEATURE
   if (position_cap)
   {
      controller.SetLongPositionCap(new PositionCapStrategy(BuySide, magic_number, no_of_buy_position, no_of_positions, symbol));
      controller.SetShortPositionCap(new PositionCapStrategy(SellSide, magic_number, no_of_sell_position, no_of_positions, symbol));
   }
   else
   {
      controller.SetLongPositionCap(new NoPositionCapStrategy());
      controller.SetShortPositionCap(new NoPositionCapStrategy());
   }
#endif

#ifdef USE_MARKET_ORDERS
   controller.SetEntryStrategy(new MarketEntryStrategy(symbol, magic_number, slippage_points));
#else
   AStream *longPrice = new LongEntryStream(symbol, timeframe);
   AStream *shortPrice = new ShortEntryStream(symbol, timeframe);
   controller.SetEntryStrategy(new PendingEntryStrategy(symbol, magic_number, slippage_points, longPrice, shortPrice));
#endif
#ifdef CUSTOM_EXIT_FEATURE
   controller.SetCustomExit(new CustomExitLogic());
#endif
   if (mandatory_closing)
      controller.SetMandatoryClosing(new DoMandatoryClosing(magic_number, slippage_points));
   else
      controller.SetMandatoryClosing(new NoMandatoryClosing());

   return controller;
}

int OnInit()
{
#ifdef SHOW_ACCOUNT_STAT
   stats = NULL;
#endif
   if (!IsDllsAllowed() && advanced_alert)
   {
      Print("Error: Dll calls must be allowed!");
      return INIT_FAILED;
   }
#ifdef MARTINGALE_FEATURE
   if (lots_type == PositionSizeRisk && martingale_type == MartingaleOnLoss)
   {
      Print("Error: martingale_type couldn't be used with this lot type!");
      return INIT_FAILED;
   }
#endif

   string error;
   TradingController *controller = CreateController(_Symbol, (ENUM_TIMEFRAMES)_Period, error);
   if (controller == NULL)
   {
      Print(error);
      return INIT_FAILED;
   }
   int controllersCount = 0;
   ArrayResize(controllers, controllersCount + 1);
   controllers[controllersCount++] = controller;
   
#ifdef SHOW_ACCOUNT_STAT
   stats = new AccountStatistics(EA_NAME);
#endif
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
#ifdef SHOW_ACCOUNT_STAT
   delete stats;
#endif
   int i_count = ArraySize(controllers);
   for (int i = 0; i < i_count; ++i)
   {
      delete controllers[i];
   }
}

void OnTick()
{
   int i_count = ArraySize(controllers);
   for (int i = 0; i < i_count; ++i)
   {
      controllers[i].DoTrading();
   }
#ifdef SHOW_ACCOUNT_STAT
   stats.Update();
#endif
}
