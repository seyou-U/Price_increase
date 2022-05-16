import React from "react";
import Modal from 'react-modal';
import PropTypes from 'prop-types';
import '../stylesheets/modal.scss';

class SelectModal extends React.Component {
  constructor() {
    super();
    this.state = {
      modalIsOpen: false
    };

    this.openModal = this.openModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  closeModal() {
    this.setState({modalIsOpen: false});
  }

  render() {
    return (
      <>
        <button className="selectButton" onClick={this.openModal}>商品を選択してください</button>
        <Modal
          isOpen={this.state.modalIsOpen}
          onRequestClose={this.closeModal}
          contentLabel="Modal"
          class="modal">
          <ProductList
            products={this.props.products} />
          <div className="modalButton">
            <a href="/" id="homePath">HOME画面へ</a>
            <button className="closeButton" onClick={this.closeModal}>閉じる</button>
          </div>
        </Modal>
      </>
    );
  }
}

function ProductList(props) {
    return (
        <>
          {props.products.map((product) => <ProductItem product={product} key={product.id} />)}
        </>
    );
}

ProductList.propTypes = {
    products: PropTypes.array.isRequired
}

function ProductItem(props) {
  const { id } = props.product;
  const { name } = props.product;
  const idStr = JSON.stringify(id)
  return (
    <>
      <div className="productList">
        <div className="productContainer">
          <div className="productName">{name}</div>
          <a href={"/products/"+idStr+"/product_keisan?id="+idStr} id="selectProduct">この商品を選択</a>
        </div>
      </div>
    </>
  );
}

ProductItem.propTypes = {
  product: PropTypes.string
}

export default SelectModal
