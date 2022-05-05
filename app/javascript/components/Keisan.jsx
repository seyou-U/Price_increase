import React from "react";
import PropTypes from "prop-types";
import '../stylesheets/keisan.scss';

class Product extends React.Component {
  constructor(props) {
    super(props)
    this.changeValue1 = this.changeValue1.bind(this)
    this.state = {
      value1: 0
    }
  }

  changeValue1(newValue) {
    this.setState({
      value1: newValue
    })
  }

  render () {
    const newValue1 = this.state.value1
    const result = this.props.price * parseInt(newValue1) * 52
    const onClickCal = () => {
      if(!isNaN(result)){
        this.setState({answer: `1年間の値上げによる損失金額は${result}円`});
      }else{
        this.setState({answer: "数字以外の文字が入力されています"});
      };
    };

    return (
      <>
        <NumericalValue  value={newValue1} valueChange={this.changeValue1}/>
        <div class="result">
          <button class="checkButton" onClick={onClickCal}>チェックしてみる</button>
          <p class="resultData">{this.state.answer}</p>
        </div>
      </>
    );
  };
}

class  NumericalValue extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this)
  }

  handleChange(e) {
    this.props.valueChange(e.target.value)
  }

  render () {
    const newValue = this.props.value
    return(
      <>
        <div class="productCalculation">
          <div class="textSide">1週間に</div>
          <input id="Text" type="text" value={newValue} onChange={this.handleChange}/>
          <div class="textSide">回購入(使用)する</div>
        </div>
      </>
    )
  }
}

Product.propTypes = {
  price: PropTypes.integer
}

export default Product
